+++
date = "2018-10-06T12:30:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "Introducing rspec-stubbed_env"
tags = [ "development", "ruby", "rails", "rubygems", "rspec-stubbed_env" ]
categories = [ "development", "tools", "ruby", "rspec"]
series = [ "toolchain" ]
type = "docs"

+++

## ENV stubbing via a shared context for more powerful tests.

[![Total Downloads](https://img.shields.io/gem/rt/rspec-stubbed_env.svg)](https://github.com/pboling/rspec-stubbed_env)
[![Downloads Today](https://img.shields.io/gem/rd/rspec-stubbed_env.svg)](https://github.com/pboling/rspec-stubbed_env)
[![Build Status](https://travis-ci.org/pboling/rspec-stubbed_env.svg?branch=master)](https://travis-ci.org/pboling/rspec-stubbed_env)
[![Maintainability](https://api.codeclimate.com/v1/badges/07a1d53634c61154efae/maintainability)](https://codeclimate.com/github/pboling/rspec-stubbed_env/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/07a1d53634c61154efae/test_coverage)](https://codeclimate.com/github/pboling/rspec-stubbed_env/test_coverage)
[![Network](https://img.shields.io/github/forks/pboling/rspec-stubbed_env.svg?style=social)](https://github.com/pboling/rspec-stubbed_env/network)
[![Stars](https://img.shields.io/github/stars/pboling/rspec-stubbed_env.svg?style=social)](https://github.com/pboling/rspec-stubbed_env/stargazers)
[![Version](https://img.shields.io/gem/v/rspec-stubbed_env.svg)](https://rubygems.org/gems/rspec-stubbed_env)
[![Build](https://img.shields.io/travis/pboling/rspec-stubbed_env.svg)](https://travis-ci.org/pboling/rspec-stubbed_env)
[![Documentation](http://inch-ci.org/github/pboling/rspec-stubbed_env.svg)](http://inch-ci.org/github/pboling/rspec-stubbed_env)
[![Depfu](https://badges.depfu.com/badges/a48948dd503f23a440f2c17910563f43/count.svg)](https://depfu.com/github/pboling/rspec-stubbed_env?project_id=5884)
[![Open Source Helpers](https://www.codetriage.com/pboling/rspec-stubbed_env/badges/users.svg)](https://www.codetriage.com/pboling/rspec-stubbed_env)
[![Chat](https://img.shields.io/gitter/room/pboling/rspec-stubbed_env.svg)](https://gitter.im/pboling/rspec-stubbed_env)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-stubbed_env', group: :test
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-stubbed_env


You must configure RSpec to use the `:expect` syntax, or some compatible alternative.

```ruby
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
```

## Usage

ENV stubbing:
 
  - is opt-in, via a shared context, rather than global.
  - *does not* affect the real ENV at all.  It is a true stub.
  - has the same scope as a `before`, `subject`, or `let` at the same level.

See the spec suite for detailed examples.

```ruby
# This is normal, without stubbing, ENV is not set
describe 'vanilla' do
  it 'has no ENV stub' do
    expect(ENV['FOO']).to be_nil
  end
end

# With a stubbed ENV!
describe 'my stubbed test' do
  include_context 'with stubbed env'
  before do
    stub_env('FOO' => 'is bar')
  end
  it 'has a value' do
    expect(ENV['FOO']).to eq('is bar')
  end
end
```
