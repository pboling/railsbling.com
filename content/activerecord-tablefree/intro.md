+++
date = "2017-11-14T14:41:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "Introducing activerecord-tablefree"
tags = [ "development", "ruby", "rails", "rubygems", "activerecord-tablefree", "database" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

## ActiveRecord Without a Database?

[![Total Downloads](https://img.shields.io/gem/rt/activerecord-tablefree.svg)](https://github.com/pboling/activerecord-tablefree)
[![Downloads Today](https://img.shields.io/gem/rd/activerecord-tablefree.svg)](https://github.com/pboling/activerecord-tablefree)
[![Build](https://img.shields.io/travis/pboling/activerecord-tablefree.svg)](https://travis-ci.org/pboling/activerecord-tablefree)
[![Test Coverage](https://api.codeclimate.com/v1/badges/9354ad73daf12d480e81/test_coverage)](https://codeclimate.com/github/pboling/activerecord-tablefree/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/9354ad73daf12d480e81/maintainability)](https://codeclimate.com/github/pboling/activerecord-tablefree/maintainability)
[![Network](https://img.shields.io/github/forks/pboling/activerecord-tablefree.svg?style=social)](https://github.com/pboling/activerecord-tablefree/network)
[![Stars](https://img.shields.io/github/stars/pboling/activerecord-tablefree.svg?style=social)](https://github.com/pboling/activerecord-tablefree/stargazers)
[![Version](https://img.shields.io/gem/v/activerecord-tablefree.svg)](https://rubygems.org/gems/activerecord-tablefree)
[![Open Source Helpers](https://www.codetriage.com/pboling/activerecord-tablefree/badges/users.svg)](https://www.codetriage.com/pboling/activerecord-tablefree) 
[![Depfu](https://badges.depfu.com/badges/96a4d507f1a61a9368655f60fa3cb70f/count.svg)](https://depfu.com/github/pboling/activerecord-tablefree?project=Bundler)
[![Chat](https://img.shields.io/gitter/room/pboling/activerecord-tablefree.svg)](https://img.shields.io/gitter/room/pboling/activerecord-tablefree.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

ActiveRecord Tablefree Models provides a simple mixin for creating models that are not bound to the database. This approach is useful for taking advantage of the features of ActiveRecord such as validation, relationships, nested_attributes, etc.

This can also be very useful in testing where a mock-like object will suffice.

This gem is exceptionally hacky.  For an alternative solution, primarily aimed at testing, that is less hacky, see my other gem [anonymous_active_record](https://rubygems.org/gems/anonymous_active_record)!

Why, why, why
-------------

Why would you ever consider this gem as opposed to ActiveModel?

ActiveModel::Model does not support relations and nested attributes.


Installation
------------

ActiveRecord Tablefree is distributed as a gem, which is how it should
be used in your app.

Include the gem in your Gemfile:

    gem "activerecord-tablefree", "~> 3.0"


Supported Versions
------------------

Supported ruby version are

  * **2.2.x** series higher than 2.2.2 (a Rails 5 requirement)
  * **2.3.x** series
  * **2.4.x** series
  * **2.5.x** series

Supported ActiveRecord versions are

  * **5.0.x** series
  * **5.1.x** series
  * **5.2.x** series

If you are using an older ActiveRecord version you can use the gem [`activerecord-tableless`](https://github.com/softace/activerecord-tableless)

This gem tries to maintain the same API as the older `activerecord-tableless` gem.

Usage
-----

Define a model like this:

    class ContactMessage < ActiveRecord::Base
      has_no_table
      column :name, :string
      column :email, :string
      column :message, :string
      validates_presence_of :name, :email, :message
    end

You can now use the model in a view like this:

    <%= form_for :contact_message, @contact_message do |f| %>
      Your name: <%= f.text_field :name %>
      Your email: <%= f.text_field :email %>
      Your message: <%= f.text_field :message %>
    <% end %>

And in the controller:

    def contact_message
      @contact_message = ContactMessage.new
      if request.post?
        @contact_message.attributes = params[:contact_message]
        if @contact_message.valid?
          # Process the message...
        end
      end
    end

If you wish (this is not recommended), you can pretend you have a succeeding database by using

    has_no_table :database => :pretend_success

Associations
------------

Some model as before, but with an association to a real DB-backed model.

```
    class ContactMessage < ActiveRecord::Base
      has_no_table
      column :message, :string
      column :email, :string
      validates_presence_of :name, :email
      belongs_to :contact, foreign_key: :email, primary_key: :email
    end

    class Contact < ActiveRecord::Base
      validates_presence_of :name, :email
      has_one :contact_message, foreign_key: :email, primary_key: :email, dependent: nil
    end
```

Obviously the association is not full-fledged, as some traversals just won't make sense with one side not being loadable from the database.  From the `ContactMessage` you can get to the `Contact`, but not vice versa.

```
>> contact = Contact.new(name: 'Boo', email: 'boo@example.com')
>> contact_message = ContactMessage.new(contact: contact)
>> contact_message.email
=> 'boo@example.com'
```
