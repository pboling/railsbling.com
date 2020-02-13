+++
date = "2016-03-08T12:30:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "Introducing rails_env_local"
tags = [ "development", "ruby", "rails", "rubygems", "rails_env_local" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

## "development" is not always the best name for the local environment

`rails_env_local`, where a rails environment for local development can be anything it desires.  Even a `butterfly`.  Tell your DevOps friends.

[Rails Guides](http://guides.rubyonrails.org/initialization.html) has more information on the Rails initialization routines.  You can easily accomplish what this gem does in a few lines of code.

... But are you going to write specs for code in your `config/boot.rb` file?  Really?

[![Total Downloads](https://img.shields.io/gem/rt/rails_env_local.svg)](https://github.com/pboling/rails_env_local)
[![Downloads Today](https://img.shields.io/gem/rd/rails_env_local.svg)](https://github.com/pboling/rails_env_local)
[![Code Quality](https://img.shields.io/codeclimate/github/pboling/rails_env_local.svg)](https://codeclimate.com/github/pboling/rails_env_local)
[![Network](https://img.shields.io/github/forks/pboling/rails_env_local.svg?style=social)](https://github.com/pboling/rails_env_local/network)
[![Stars](https://img.shields.io/github/stars/pboling/rails_env_local.svg?style=social)](https://github.com/pboling/rails_env_local/stargazers)
[![Version](https://img.shields.io/gem/v/rails_env_local.svg)](https://rubygems.org/gems/rails_env_local)
[![Build](https://img.shields.io/travis/pboling/rails_env_local.svg)](https://travis-ci.org/pboling/rails_env_local)
[![Documentation](http://inch-ci.org/github/pboling/rails_env_local.svg)](http://inch-ci.org/github/pboling/rails_env_local)
[![Depfu](https://badges.depfu.com/badges/5f15cea25ab8994b8b60e5f597d27b00/count.svg)](https://depfu.com/github/pboling/rails_env_local?project_id=2722)
[![Chat](https://img.shields.io/gitter/room/pboling/rails_env_local.svg)](https://gitter.im/pboling/rails_env_local)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_env_local', require: false
```

`require: false` because we want to control when it is loaded.

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_env_local

## Usage

In config/boot.rb you have:

    require 'bundler/setup'

After that line (or before, see NOTE below) add:

    require 'rails_env_local'
    RailsEnvLocal.set_local_environment

NOTE: If you need your custom local environment to be set before some of the other gems you use, because they rely on the environment being set early, then just place the two lines above *before* the `require 'bundler/setup'`.  Simple as that.

## Compatibility

This gem works with any version of Rails that uses `Rails.env`, *but* it is only tested with Rails 3.2, 4.1, 4.2, and 5.0.

This gem is tested with Ruby 2.2-latest and 2.3-latest.  It should work with any version of Ruby that supports both Ruby 1.9 hashes and double splat arguments.

## Theory

### Q: Why not just "local" as the default?

A: It is too generic.  "local" is often used in the same ordinal position as, but with a different meaning than, the environment name.  For one example of this see: https://github.com/bkeepers/dotenv#multiple-rails-environments

### Q: Why not just hand roll this when you need it?  Only a few lines of code.

A: Doing it right requires remembering a number of things that are easily forgotten since this is a set it and forget it type configuration.  If you don't start a new project every week, you may lose details on how to properly override the RAILS_ENV for local development (e.g. you may forget that naming it "local" is a bad idea and consequently break the `dotenv` gem).  Also if you have a large team you may not want to force them all to add an `export RAILS_ENV=localdev` statement to their shell profile.

### Q: Using this gem takes over the "development" environment namespace to be something else, so it precludes using "development" as a deployed environment. 

A: Yeah, pretty much.  Name your deployed environment "dev", "develop", or "anything_else".  Naming your deployed environment "development", when "development" is universally understood to be local development in Rails, is a recipe for confusion.

### Options:

#### `environment`
  * Type: a string
  * Default: `"localdev"`
  * Effect: Sets the Rails environment (`Rails.env`) to the given string
  * Example:
```ruby
    RailsEnvLocal.set_local_environment(environment: "panda")
```

#### `verbose`
  * Type: boolean
  * Default: `false`
  * Effect: Prints the environment to `STDOUT` as it is being set
  * Example:
```ruby
    RailsEnvLocal.set_local_environment(verbose: true)
```

#### `set_rack_env`
  * Type: boolean
  * Default: `true`
  * Effect: In addition to setting `Rails.env`, will set `ENV["RAILS_ENV"]` to match `Rails.env`
  * Example:
```ruby
    RailsEnvLocal.set_local_environment(set_rack_env: false)
```

#### `set_rails_env`
  * Type: boolean
  * Default: `true`
  * Effect: In addition to setting `Rails.env`, will set `ENV["RACK_ENV"]` to match `Rails.env`
  * Example:
```ruby
    RailsEnvLocal.set_local_environment(set_rails_env: false)
```

#### `force`
  * Type: boolean
  * Default: `false`
  * Effect: Setting `Rails.env`, no matter what, and `RAILS_ENV` / `RACK_ENV` variables according to other options given.
  * Example:
```ruby
    RailsEnvLocal.set_local_environment(force: true)
```
