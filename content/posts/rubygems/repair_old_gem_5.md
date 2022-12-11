+++
date = "2022-12-11T23:52:22+07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
hero = "images/posts/writing/jon-tyson-rXi6VEpoSqQ-unsplash-1920-1095-crop.png"
title = "How to Repair an Old Gem (Part 5) - Rakefile & RuboCop LTS"
tags = [ "development", "ruby", "rubygems", "floss" ]
categories = [ "development", "tools", "ruby", "maintenance" ]
series = [ "RubyGemRepair" ]

[menu]
[menu.sidebar]
name = "Rakefile & RuboCop LTS (Part 5)"
identifier = "repair_old_gem_5"
parent = "rubygems"
weight = 15

+++

Checkout [Part 1](/posts/rubygems/repair_old_gem_1),
[Part 2](/posts/rubygems/repair_old_gem_2),
[Part 3](/posts/rubygems/repair_old_gem_3), and
[Part 4](/posts/rubygems/repair_old_gem_4) of the series first!

In the early days of writing Ruby libraries there were many patterns, and it took time to discover problems with each, if any.
[By 2009 (well after the release of Ruby 1.8.7)](https://tomayko.com/blog/2009/require-rubygems-antipattern)
it had become clear using the statement `require "rubygems"` from inside a rubygem library is problematic.

So we'll rip it out of the `os` source!
```ruby
require 'rubygems' if RUBY_VERSION < '1.9.0'
```
Interesting that it seems there was a reason to think Ruby 1.8.7 needed this hack, 
but an alternative solution to whatever this was working around, must be to install a newer version of rubygems.
The latest version of rubygems that can be installed on Ruby 1.8.7 does not need this hack.

Next we apply some best practices to the Rakefile.  I use the following in most of my RubyGem projects:
```ruby
# encoding: utf-8
# frozen_string_literal: true

# !/usr/bin/env rake

require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  desc 'spec task stub'
  task :spec do
    warn 'rspec is disabled'
  end
end
desc 'alias test task to spec'
task :test => :spec

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |task|
    task.options = ['-D'] # Display the name of the failing cops
  end
rescue LoadError
  desc 'rubocop task stub'
  task :rubocop do
    warn 'RuboCop is disabled'
  end
end

task default: %i[test rubocop]
```

But wait, this project doesn't have RuboCop yet.
Adding latest RuboCop for a project that still supports Ruby 1.8 or 1.9 is risky, if you calue your time.
That's one reason I created `rubocop-lts` with a set of Ruby 1.8 styles pre-defined.
Drop it in the `gemspec`, and forget it until you drop some old Rubies.
```ruby
  s.add_development_dependency('rubocop-lts'.freeze, ['~> 2.0']) # For Ruby 1.8.7 compat
```
Then create a `.rubocop.yml`:
```yaml
inherit_gem:
  rubocop-lts: rubocop-lts1_8.yml
```
Then we can auto fix most things:
```shell
bundle exec rubocop -a
```
Then we can fix other things that were not auto-fixable, and put the rest into a "todo" config:
```shell
bundle exec rubocop --auto-gen-config
```
Then we add the `todo` config to the main config, so we end up with:
```yaml
inherit_from: .rubocop_todo.yml

inherit_gem:
  rubocop-lts: rubocop-lts1_8.yml
```
Then we can run `bundle exec rake`:
```shell
$ bundle exec rake
...
Finished in 0.05178 seconds (files took 0.21842 seconds to load)
36 examples, 0 failures

Randomized with seed 46919

Running RuboCop...
Inspecting 10 files
..........

10 files inspected, no offenses detected
```

Now we have a useful `Rakefile` and our code is much more modern, while remaining compatible with Ruby 1.8.7 syntax.

Check out the [pull request](https://github.com/rdp/os/pull/72)
and give it a thumbs up or a heart if you are feeling generous!

Stay tuned for further posts in this series!

> [Hero image (cropped)](https://unsplash.com/photos/rXi6VEpoSqQ) by [Jon Tyson](https://unsplash.com/@jontyson)
