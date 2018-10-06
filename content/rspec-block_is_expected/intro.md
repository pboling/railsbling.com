+++
date = "2018-10-01T12:30:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "Introducing rspec-block_is_expected"
tags = [ "development", "ruby", "rails", "rubygems", "rspec-block_is_expected" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

## Allows you to use `block_is_expected` similarly to how you would use `is_expected` if a block was wrapping the subject.

[![Total Downloads](https://img.shields.io/gem/rt/rspec-block_is_expected.svg)](https://github.com/pboling/rspec-block_is_expected)
[![Downloads Today](https://img.shields.io/gem/rd/rspec-block_is_expected.svg)](https://github.com/pboling/rspec-block_is_expected)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ca0a12604ecc19f5e76d/test_coverage)](https://codeclimate.com/github/pboling/rspec-block_is_expected/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/ca0a12604ecc19f5e76d/maintainability)](https://codeclimate.com/github/pboling/rspec-block_is_expected/maintainability)
[![Network](https://img.shields.io/github/forks/pboling/rspec-block_is_expected.svg?style=social)](https://github.com/pboling/rspec-block_is_expected/network)
[![Stars](https://img.shields.io/github/stars/pboling/rspec-block_is_expected.svg?style=social)](https://github.com/pboling/rspec-block_is_expected/stargazers)
[![Version](https://img.shields.io/gem/v/rspec-block_is_expected.svg)](https://rubygems.org/gems/rspec-block_is_expected)
[![Build](https://img.shields.io/travis/pboling/rspec-block_is_expected.svg)](https://travis-ci.org/pboling/rspec-block_is_expected)
[![Documentation](http://inch-ci.org/github/pboling/rspec-block_is_expected.svg)](http://inch-ci.org/github/pboling/rspec-block_is_expected)
[![Depfu](https://badges.depfu.com/badges/272ce0df3bc6df5cbea9354e2c3b65af/count.svg)](https://depfu.com/github/pboling/rspec-block_is_expected?project_id=5614)
[![Open Source Helpers](https://www.codetriage.com/pboling/rspec-block_is_expected/badges/users.svg)](https://www.codetriage.com/pboling/rspec-block_is_expected)
[![Chat](https://img.shields.io/gitter/room/pboling/rspec-block_is_expected.svg)](https://gitter.im/pboling/rspec-block_is_expected)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

This gem does one very simple thing very well.  It allows you to use `block_is_expected` similarly to how you would use `is_expected` if a block was wrapping the subject.  Supports the same versions of Ruby that RSpec does, 1.8.7 - current ruby-head, as well as the JRuby equivalents.

```ruby
subject { Integer(nil) }
it('raises') { block_is_expected.to raise_error(TypeError) }
```

If you only ever want to test subjects wrapped in blocks, and are comfortable with **losing** the standard `is_expected` behavior, see an alternative to this gem [here](https://github.com/christopheraue/ruby-rspec-is_expected_block/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-block_is_expected', group: :test
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-block_is_expected

## Configuration

There is no configuration needed if you your test suite loads the bundle group (e.g. `test`) that you added the gem to.

Otherwise, you may load it manually near the top of your `spec_helper.rb`, and it will self configure.
```ruby
require 'rspec/block_is_expected'
```

## Usage

The spec suite for this gem has some examples of usage, lightly edited here.

```ruby
RSpec.describe 'TestyMcTest' do
  context 'errors raised' do
    subject { Integer(nil) }
    it('can be tested') do
      # Where you used to have:
      # expect { subject }.to raise_error(TypeError)
      block_is_expected.to raise_error(TypeError)
    end
  end
  context 'execution' do
    let(:mutex) { Mutex.new }
    subject { mutex.lock }
    it('can change state') do
      expect(mutex.locked?).to eq(false)
      # Where you used to have:
      # expect { subject }.to_not raise_error
      block_is_expected.to_not raise_error
      expect(mutex.locked?).to eq(true)
    end
  end
  context 'changed state' do
    let(:mutex) { Mutex.new }
    subject { mutex.lock }
    it('can be tested') do
      # Where you used to have:
      # expect { subject }.to change { mutex.locked? }.from(false).to(true)
      block_is_expected.to change { mutex.locked? }.from(false).to(true)
    end
  end
end
```

