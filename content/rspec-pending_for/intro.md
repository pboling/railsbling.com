+++
date = "2015-10-22T12:30:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "Introducing rspec-pending_for"
tags = [ "development", "ruby", "rails", "rubygems", "rspec-pending_for" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

## Mark specs pending or skipped for specific Ruby engine (e.g. MRI or JRuby) / version combinations.

[![Total Downloads](https://img.shields.io/gem/rt/rspec-pending_for.svg)](https://github.com/pboling/rspec-pending_for)
[![Downloads Today](https://img.shields.io/gem/rd/rspec-pending_for.svg)](https://github.com/pboling/rspec-pending_for)
[![Test Coverage](https://api.codeclimate.com/v1/badges/266bc0935f185153cce4/test_coverage)](https://codeclimate.com/github/pboling/rspec-pending_for/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/266bc0935f185153cce4/maintainability)](https://codeclimate.com/github/pboling/rspec-pending_for/maintainability)
[![Network](https://img.shields.io/github/forks/pboling/rspec-pending_for.svg?style=social)](https://github.com/pboling/rspec-pending_for/network)
[![Stars](https://img.shields.io/github/stars/pboling/rspec-pending_for.svg?style=social)](https://github.com/pboling/rspec-pending_for/stargazers)
[![Version](https://img.shields.io/gem/v/rspec-pending_for.svg)](https://rubygems.org/gems/rspec-pending_for)
[![Build](https://img.shields.io/travis/pboling/rspec-pending_for.svg)](https://travis-ci.org/pboling/rspec-pending_for)
[![Documentation](http://inch-ci.org/github/pboling/rspec-pending_for.svg)](http://inch-ci.org/github/pboling/rspec-pending_for)
[![Depfu](https://badges.depfu.com/badges/79867e590f063376f40b031a1447c215/count.svg)](https://depfu.com/github/pboling/rspec-block_is_expected?project_id=5865)[![Open Source Helpers](https://www.codetriage.com/pboling/rspec-pending_for/badges/users.svg)](https://www.codetriage.com/pboling/rspec-pending_for)
[![Chat](https://img.shields.io/gitter/room/pboling/rspec-pending_for.svg)](https://gitter.im/pboling/rspec-pending_for)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

Easiest to just show you:

```ruby
it("blah is blah") do
  pending_for(engine: "rbx")
  pending_for(engine: "ruby", versions: "2.1.5")
  pending_for(engine: "jruby", versions: "2.2.2", reason: "due to a bug in Ruby")
  pending_for(engine: "ruby", versions: "2.0.0", reason: "because I don't have the time")
  expect("blah").to eq "blah"
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-pending_for'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-pending_for

## Usage

The gem auto-configures itself for use in your Rspec suite.  Just add this line to yous `spec_helper.rb`:

```ruby
require 'rspec/pending_for'
```

To mark a spec pending for a specific ruby engine, and/or versions:

```ruby
it("blah is blah") do
  pending_for(engine: "ruby", versions: "2.1.5")
  expect("blah").to eq "blah"
end
```

To skip a spec for a specific ruby engine, and/or versions:

```ruby
it("blah is blah") do
  skip_for(engine: "ruby", versions: "2.1.5")
  expect("blah").to eq "blah"
end
```

To mark a spec pending for all versions of a given engine:

```ruby
it("blah is blah") do
  pending_for(engine: "jruby")
  expect("blah").to eq "blah"
end
```

To mark a spec pending for a custom reason (overriding the default message):

```ruby
it("blah is blah") do
  pending_for(engine: "jruby", reason: "This does not work on JRuby")
  expect("blah").to eq "blah"
end
```

To mark a spec pending or skipped for multiple engines and versions, just what you would expect:

```ruby
it("blah is blah") do
  skip_for(engine: "jruby", reason: "This does not work on JRuby so skipping for now") # All JRuby versions will be skipped
  pending_for(engine: "rbx", reason: "This does not work on Rubinius so pending for now") # All rbx versions will be pending
  pending_for(engine: "ruby", versions:%w(1.9.3 2.0.0 2.1.0)) # uses the default message
  expect("blah").to eq "blah"
end
```
