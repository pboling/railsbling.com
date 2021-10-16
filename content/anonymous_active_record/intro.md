+++
date = "2018-01-04T14:41:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "Introducing anonymous_active_record"
tags = [ "development", "ruby", "rails", "rubygems", "anonymous_active_record", "database", "active_record" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

## ActiveRecord Without a Database?

[![Total Downloads](https://img.shields.io/gem/rt/anonymous_active_record.svg)](https://github.com/pboling/anonymous_active_record)
[![Downloads Today](https://img.shields.io/gem/rd/anonymous_active_record.svg)](https://github.com/pboling/anonymous_active_record)
[![Code Quality](https://img.shields.io/codeclimate/github/pboling/anonymous_active_record.svg)](https://codeclimate.com/github/pboling/anonymous_active_record)
[![Network](https://img.shields.io/github/forks/pboling/anonymous_active_record.svg?style=social)](https://github.com/pboling/anonymous_active_record/network)
[![Stars](https://img.shields.io/github/stars/pboling/anonymous_active_record.svg?style=social)](https://github.com/pboling/anonymous_active_record/stargazers)
[![Version](https://img.shields.io/gem/v/anonymous_active_record.svg)](https://rubygems.org/gems/anonymous_active_record)
[![Build](https://img.shields.io/travis/pboling/anonymous_active_record.svg)](https://travis-ci.org/pboling/anonymous_active_record)
[![Documentation](http://inch-ci.org/github/pboling/anonymous_active_record.svg)](http://inch-ci.org/github/pboling/anonymous_active_record)
[![Depfu](https://badges.depfu.com/badges/96a4d507f1a61a9368655f60fa3cb70f/count.svg)](https://depfu.com/github/pboling/anonymous_active_record?project=Bundler)
[![Chat](https://img.shields.io/gitter/room/pboling/anonymous_active_record.svg)](https://img.shields.io/gitter/room/pboling/anonymous_active_record.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)


Replacement for broken `Class.new(ActiveRecord::Base)`.

Very useful in testing Rails apps, and even more so for testing gems without having to specify full blown models.

If you prefer an exceptionally hacky alternative that could also be used for real runtime code, see my other gem [activerecord-tablefree](https://rubygems.org/gems/activerecord-tablefree)!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'anonymous_active_record'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install anonymous_active_record

## Usage

Require the library in your `spec_helper` or other test suite boot file.

```ruby
require 'anonymous_active_record'
```

Let's say you want to write specs for a module, `HasBalloon`, which provides a method `has_balloon?`, and will be mixed into ActiveRecord classes.

```ruby
module HasBalloon
  def has_balloon?
    name == 'Spot' ? true : false # only Spot has a balloon
  end
end
```

This won't work [(really!)](https://github.com/rails/rails/issues/8934):

```ruby
  let(:ar_with_balloon) do
    Class.new(ActiveRecord::Base) do
      attr_accessor :name
      include HasBalloon
      def flowery_name
        "#{b_f}#{name}#{b_f}"
      end
      def b_f
        has_balloon? ? '🎈' : '🌸'
      end
    end
  end
```

So do this instead:

```ruby
  let(:ar_with_balloon) do
    AnonymousActiveRecord.generate(columns: ['name']) do
      include HasBalloon
      def flowery_name
        "#{b_f}#{name}#{b_f}"
      end
      def b_f
        has_balloon? ? '🎈' : '🌸'
      end
    end
  end
  it 'can test the module' do
    expect(ar_with_balloon.new(name: 'Spot').flowery_name).to eq('🎈Spot🎈')
    expect(ar_with_balloon.new(name: 'Not Spot').flowery_name).to eq('🌸Not Spot🌸')
  end
```

### Generate Options

```ruby
AnonymousActiveRecord.generate(
    table_name: 'a_table_name', 
        # if table_name is not set klass_basename will be used to derive a unique random table_name
        # default is a unique random table name
    klass_basename: 'anons', # is default
    columns: ['name'], 
        # default is [], 
        # meaning class will have ['id', 'created_at', 'updated_at'], as the AR defaults
    timestamps: true, # is default
    connection_params: { adapter: 'sqlite3', encoding: 'utf8', database: ':memory:' } # is default
) do
   # code which becomes part of the class definition
end
```

The block is optional.

### Factory Options

```ruby
AnonymousActiveRecord.factory(
    source_data: [{name: 'Phil'}, {name: 'Vickie'}],
        # Array of hashes, where each hash represents a record that will be created
    # ... The rest of the options are the same as for generate, see above.
) do
  # same as for generate, see above.
end
```

The block is optional.

There is also a `factory!` method that will raise if the create fails, accomplished by calling `create!` instead of `create`.
