+++
date = "2018-09-21T11:00:00-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "require_bench"
tags = [ "Development", "Ruby", "rails", "RubyGems", "require_bench" ]
categories = [ "Development", "tools", "Ruby" ]
series = [ "Toolchain" ]
type = "docs"

+++

## Ruby Bootstrapping Analysis

[![Total Downloads](https://img.shields.io/gem/rt/require_bench.svg)](https://github.com/pboling/require_bench)
[![Downloads Today](https://img.shields.io/gem/rd/require_bench.svg)](https://github.com/pboling/require_bench)
[![Network](https://img.shields.io/github/forks/pboling/require_bench.svg?style=social)](https://github.com/pboling/require_bench/network)
[![Stars](https://img.shields.io/github/stars/pboling/require_bench.svg?style=social)](https://github.com/pboling/require_bench/stargazers)
[![Version](https://img.shields.io/gem/v/require_bench.svg)](https://rubygems.org/gems/require_bench)
[![Build](https://img.shields.io/travis/pboling/require_bench.svg)](https://travis-ci.org/pboling/require_bench)
[![Maintainability](https://api.codeclimate.com/v1/badges/18523205c207a2b53045/maintainability)](https://codeclimate.com/github/pboling/require_bench/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/18523205c207a2b53045/test_coverage)](https://codeclimate.com/github/pboling/require_bench/test_coverage)
[![Depfu](https://badges.depfu.com/badges/247bffc753b0cd49d3c08ce03b5c251c/count.svg)](https://depfu.com/github/pboling/require_bench?project_id=5824)
[![Open Source Helpers](https://www.codetriage.com/pboling/require_bench/badges/users.svg)](https://www.codetriage.com/pboling/require_bench)
[![Chat](https://img.shields.io/gitter/room/pboling/require_bench.svg)](https://gitter.im/pboling/require_bench)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

Ruby app loading slowly, or never?

Discover bootstrapping issues in Ruby by benchmarking "Kernel.require"

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'require_bench'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install require_bench

## Usage

Require the library where it will be loaded prior to any other requires you want to benchmark.

```ruby
require 'require_bench'
```

By default this gem does **nothing**, hacks **nothing**, and has **zero** effects.

### Turn on benchmarking & output

Add an environment variable, however you normally do such things, so that in Ruby:

```ruby
ENV['REQUIRE_BENCH'] == 'true'
```

Any value other than `'true'` means RubyBench is still turned off.

### Handy Rake Task for Rails:

Require in Rakefile, as follows:

```ruby
  require 'bundler/setup'
  require 'require_bench/tasks' # Near the top, just below require 'bundler/setup'!
```

This will ensure it will load before other stuff.

When running from command line, you will see output as the Rails app boots.
```bash
∴ REQUIRE_BENCH=true bundle exec rake require_bench:hello
[RequireBench]  12.179703 /path/to/my_app/config/application
[RequireBench]   0.001726 resque/tasks
[RequireBench]   0.000917 resque/scheduler/tasks
[RequireBench]   0.000011 rake
[RequireBench]   0.000014 active_record
[RequireBench]   0.008673 sprockets/rails/task
[RequireBench]   0.000012 dynamoid
[RequireBench]   0.000004 dynamoid/tasks/database
[RequireBench]   0.000012 raven/integrations/tasks
[RequireBench]   0.003107 rspec/core/rake_task
[RequireBench]   0.000017 csv
[RequireBench]   0.000012 resque/tasks
[RequireBench]   0.000007 resque/scheduler/tasks
[RequireBench]   0.064950 rails/tasks
[RequireBench]   0.003305 rake/testtask
[RequireBench]   0.001886 rubocop/rake_task
[RequireBench]   0.000012 hubspot-ruby
[RequireBench]   2.291259 /path/to/my_app/config/environment.rb

[RequireBench] Slowest Loads by Library, in order
 1.  11.914224 /path/to/my_app/config/application
 2.   2.153282 /path/to/my_app/config/environment.rb
 3.   0.061008 rails
 4.   0.010827 sprockets
 5.   0.003179 rspec
 6.   0.003144 rake
 7.   0.003127 resque
 8.   0.001543 rubocop
 9.   0.000021 dynamoid
10.   0.000016 csv
11.   0.000016 active_record
12.   0.000010 raven
13.   0.000005 hubspot-ruby
==========
 14.150402 TOTAL
```

### Output Options

If the output is too noisy from deep libraries you can add a regex to skip benchmarking of files that match.

If the value is set in the shell, it should be a string.  RequireBench will split the string by comma, Regexp escape each value, and join together with pipe (`|`) to form the regex pattern.

```bash
export REQUIRE_BENCH_SKIP_PATTERN=activesupport,rspec
```

If the `ENV['REQUIRE_BENCH_SKIP_PATTERN']` value is set in Ruby, it can be one of:
  * a string, to be split by comma, each Regexp escaped, then joined by pipe (`|`)
  * an array of strings, each to be Regexp escaped, then joined by pipe (`|`)
  * a Regexp object, which will be used as is.

```ruby
ENV['REQUIRE_BENCH_SKIP_PATTERN'] = 'activesupport,rspec'
# or
ENV['REQUIRE_BENCH_SKIP_PATTERN'] = [ 'activesupport', 'rspec' ]
# or
ENV['REQUIRE_BENCH_SKIP_PATTERN'] = Regexp.new('activesupport|rspec')
```

Any file being required that matches the pattern will use the standard, rather than the benchmarked, require.

#### Fully qualified paths

Fully qualified paths, or any portion thereof, are fine, because the strings are always Regexp escaped.

