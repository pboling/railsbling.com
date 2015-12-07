+++
date = "2015-12-07T01:27:16-08:00"
draft = false
title = "Introducing celluloid-io-pg-listener"
tags = [ "Development", "Ruby", "rails", "RubyGems", "celluloid-io-pg-listener" ]
categories = [ "Development", "tools", "Ruby", "async", "evented", "threaded" ]
series = [ "Introductions" ]

+++

# Introducing a new RubyGem

`celluloid-io-pg-listener` (on [github](https://github.com/pboling/celluloid-io-pg-listener))

Allows you to asynchronously LISTEN for Postgresql NOTIFY messages and do something with the payloads.

[![Downloads Today](https://img.shields.io/gem/rd/celluloid-io-pg-listener.svg)](https://github.com/pboling/celluloid-io-pg-listener)
[![Code Quality](https://img.shields.io/codeclimate/github/pboling/celluloid-io-pg-listener.svg)](https://codeclimate.com/github/pboling/celluloid-io-pg-listener)
[![Network](https://img.shields.io/github/forks/pboling/celluloid-io-pg-listener.svg?style=social)](https://github.com/pboling/celluloid-io-pg-listener/network)
[![Stars](https://img.shields.io/github/stars/pboling/celluloid-io-pg-listener.svg?style=social)](https://github.com/pboling/celluloid-io-pg-listener/stargazers)
[![Version](https://img.shields.io/gem/v/celluloid-io-pg-listener.svg)](https://rubygems.org/gems/celluloid-io-pg-listener)
[![Documentation](http://inch-ci.org/github/pboling/celluloid-io-pg-listener.png)](http://inch-ci.org/github/pboling/celluloid-io-pg-listener)
[![Dependency Status](https://gemnasium.com/pboling/celluloid-io-pg-listener.png)](https://gemnasium.com/pboling/celluloid-io-pg-listener)


<a href="https://github.com/pboling/celluloid-io-pg-listener/issues/2">
  <img src="/images/interesting-celluloid-io-pg-listener.png" alt="Interesting Project!" style="width: 700px;"/>
</a>

Sure! 

It should work if you just run `bin/setup` from the root directory of the gem, then you can follow along the examples in the readme.

All the data about db setup and structure is located in the `spec/apps` directory.

In `spec/apps/Rakefile` you will find a `test_db_setup` task. Check it out. ;)

## A real Example

I am currently using a two stage approach to make my setup fault tolerant, redundant, and totally asynchronous.

Here is a slightly simplified, generic, version:

Note: In PostgreSQL a schema is more aptly understood as a "namespace".
Note: To use the PostgresSQL function `json_build_object` you will need to use Postgres >= 9.4, which is fairly recent.

### 2 Tables

Given a Heroku Connect (i.e. Salesforce) "account" table in the "salesforce" schema, something like this:

```
  create_table "salesforce.account", :force => true do |t|
    t.string    "sfid"
    t.string    "personemail"
    t.string    "firstname"
    t.string    "lastname"
    t.string    "phone"
    t.string    "postalcode"
    t.datetime  "createddate"
    # ... and whatever else
  end
```

Which resides in my app's database, but in a different schema ("salesforce", rather than "public").

And given a `"pg_notify_logs"` table in your apps' schema:

```
  create_table "pg_notify_logs", :force => true do |t|
    t.integer  "notify_column_unique_value"
    t.string   "notify_column"
    t.string   "notify_table"
    t.string   "notify_channel"
    t.text     "notify_payload"
    t.string   "notify_type"
    t.text     "notify_row"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end
```

### A Function and a Trigger for Heroku Connect

#### Heroku Connect Function

```
CREATE OR REPLACE FUNCTION salesforce.push_account_insert_to_pg_notify_logs_function()
  RETURNS trigger AS
$BODY$
DECLARE
  notify_column_unique_val bigint;
  channel_name_value varchar;
  notify_payload_json_value text;
  notify_table_name varchar;
  timestamp_value timestamp;
BEGIN
  notify_column_unique_val = NEW.id;
  notify_table_name = TG_TABLE_SCHEMA || '.' || TG_TABLE_NAME;
  channel_name_value = lower(TG_TABLE_SCHEMA || '_' || TG_TABLE_NAME || '_' || TG_OP);
  notify_payload_json_value = json_build_object('table', notify_table_name, 'id', notify_column_unique_val, 'type', TG_OP)::text;
  timestamp_value = COALESCE(NEW.createddate, CURRENT_TIMESTAMP);
  SET TIME ZONE 'UTC';
  INSERT INTO
    public.pg_notify_logs
      (notify_column_unique_value,notify_column,notify_table,notify_channel,notify_payload,notify_type,notify_row,created_at,updated_at)
    VALUES
      (notify_column_unique_val,'id',notify_table_name,channel_name_value,notify_payload_json_value,TG_OP,row_to_json(NEW),timestamp_value,timestamp_value);
  RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;
```

#### Heroku Connect Trigger

```
DROP TRIGGER IF EXISTS account_inserted ON salesforce.account;
CREATE TRIGGER account_inserted BEFORE INSERT ON salesforce.account
FOR EACH ROW EXECUTE PROCEDURE salesforce.push_account_insert_to_pg_notify_logs_function();
```

NOTE: To run the SQL above within Rails you have to switch the search path (and make sure to switch it back afterward, google to find more elegant solutions to this):

```
# before:
ActiveRecord::Base.connection.schema_search_path = "salesforce"
# after:
ActiveRecord::Base.connection.schema_search_path = %{"$user", public}
```

### A Function and a Trigger for Your App

#### Function
```
CREATE OR REPLACE FUNCTION notify_on_pg_notify_logs_insert_function()
  RETURNS trigger AS
$BODY$
BEGIN
  SET TIME ZONE 'UTC';
  PERFORM pg_notify(NEW.notify_channel, json_build_object('id', NEW.id)::text);
  RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;
```

#### Trigger

```
DROP TRIGGER IF EXISTS pg_notify_logs_inserted ON pg_notify_logs;
CREATE TRIGGER pg_notify_logs_inserted BEFORE INSERT ON pg_notify_logs
FOR EACH ROW EXECUTE PROCEDURE notify_on_pg_notify_logs_insert_function();
```

I use a "supervisor" to do the listening.  See the bin/ directory of this project for an example.

What I have at the end is a `pg_notify_logs` table that fill up with logs of all the inserts into the "salesforce.account" table.  I then have my listener client (built with this gem) insert jobs into Redis for working by my queue workers which do whatever I want with the data (Sidekiq, Resque).  I can either delete the `pg_notify_logs` records, or mark them as 'processed'.  I could also record errors in processing there, but I haven't gotten that far yet.

Let me know if this answered your questions!
