+++
date = "2016-03-28T14:41:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "Introducing activerecord-transactionable"
tags = [ "development", "ruby", "rails", "rubygems", "activerecord-transactionable", "database" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

# Properly Implement ActiveRecord Transactions

[![Total Downloads](https://img.shields.io/gem/rt/activerecord-transactionable.svg)](https://github.com/pboling/activerecord-transactionable)
[![Downloads Today](https://img.shields.io/gem/rd/activerecord-transactionable.svg)](https://github.com/pboling/activerecord-transactionable)
[![Code Quality](https://img.shields.io/codeclimate/github/pboling/activerecord-transactionable.svg)](https://codeclimate.com/github/pboling/activerecord-transactionable)
[![Network](https://img.shields.io/github/forks/pboling/activerecord-transactionable.svg?style=social)](https://github.com/pboling/activerecord-transactionable/network)
[![Stars](https://img.shields.io/github/stars/pboling/activerecord-transactionable.svg?style=social)](https://github.com/pboling/activerecord-transactionable/stargazers)
[![Version](https://img.shields.io/gem/v/activerecord-transactionable.svg)](https://rubygems.org/gems/activerecord-transactionable)
[![Build](https://img.shields.io/travis/pboling/activerecord-transactionable.svg)](https://travis-ci.org/pboling/activerecord-transactionable)
[![Documentation](http://inch-ci.org/github/pboling/activerecord-transactionable.svg)](http://inch-ci.org/github/pboling/activerecord-transactionable)
[![Depfu](https://badges.depfu.com/badges/96a4d507f1a61a9368655f60fa3cb70f/count.svg)](https://depfu.com/github/pboling/activerecord-transactionable?project=Bundler)
[![Chat](https://img.shields.io/gitter/room/pboling/activerecord-transactionable.svg)](https://img.shields.io/gitter/room/pboling/activerecord-transactionable.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

Provides a method, `transaction_wrapper` at the class and instance levels that can be used instead of `ActiveRecord#transaction`.  Enables you to do transactions properly, with custom rescues and retry, including with or without locking.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-transactionable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-transactionable

## Usage

```ruby
class Car < ActiveRecord::Base
  include Activerecord::Transactionable # Note lowercase "r" in Activerecord (different namespace than rails' module)

  validates_presence_of :name
end
```

When creating, saving, deleting within the transaction make sure to use the bang methods (`!`) in order to ensure a rollback on failure.

When everything works:

```ruby
car = Car.new(name: "Fiesta")
car.transaction_wrapper do
  car.save!
end
car.persisted? # => true
```

When something goes wrong:

```ruby
car = Car.new(name: nil)
car.transaction_wrapper do
  car.save!
end
car.persisted? # => false
car.errors.full_messages # => ["Name can't be blank"]
```

These examples are too simple to be useful with transactions, but if you are working with multiple records then it will make sense.

Also see the specs.

If you need to lock the car as well as have a transaction (note: will reload the `car`):

```ruby
car = Car.new(name: nil)
car.transaction_wrapper(lock: true) do # uses ActiveRecord's with_lock
  car.save!
end
car.persisted? # => false
car.errors.full_messages # => ["Name can't be blank"]
```

If you need to know if the transaction succeeded:

```ruby
car = Car.new(name: nil)
result = car.transaction_wrapper(lock: true) do # uses ActiveRecord's with_lock
           car.save!
         end
result # => an instance of Activerecord::Transactionable::Result
result.success? # => true or false
```

## Update Example

```ruby
@client = Client.find(params[:id])
transaction_result =  @client.transaction_wrapper(lock: true) do
                        @client.assign_attributes(client_params)
                        @client.save!
                      end
if transaction_result.success?
  render :show, locals: { client: @client }, status: :ok
else
  # Something prevented update, transaction_result.to_h will have all the available details
  render json: { record_errors: @client.errors, transaction_result: transaction_result.to_h }, status: :unprocessable_entity
end
```

## Find or create

NOTE: The `is_retry` is passed to the block by the gem, and indicates whether the block is running for the first time or the second, or nth, time.
The block will never be retried more than once.

```ruby
Car.transaction_wrapper(outside_retriable_errors: ActivRecord::RecordNotFound, outside_num_retry_attempts: 3) do |is_retry|
  # is_retry will be falsey on first attempt, thereafter will be the integer number of the attempt
  if is_retry
    Car.create!(vin: vin)
  else
    Car.find_by!(vin: vin)
  end
end
```

## Create or find

NOTE: The `is_retry` is passed to the block by the gem, and indicates whether the block is running for the first time or the second time.
The block will never be retried more than once.

```ruby
Car.transaction_wrapper(outside_retriable_errors: ActivRecord::RecordNotUnique) do |is_retry|
  # is_retry will be falsey on first attempt, thereafter will be the integer number of the attempt
  if is_retry
    Car.find_by!(vin: vin)
  else
    Car.create!(vin: vin)
  end
end
```

## Reporting to SAAS Error Tools (like Raygun, etc)

Hopefully there will be a better integration at some point, but for now, somewhere in your code do:

```ruby
module SendToRaygun
  def transaction_error_logger(**args)
    super
    if args[:error]
      begin
        Raygun.track_exception(args[:error])
        Rails.logger.debug("Sent Error to Raygun: #{args[:error].class}: #{args[:error].message}")
      rescue => e
        Rails.logger.debug("Sending Error #{args[:error].class}: #{args[:error].message} to Raygun Failed with: #{e.class}: #{e.message}")
      end
    end
  end
end

Activerecord::Transactionable::ClassMethods.class_eval do
  prepend SendToRaygun
end
```
