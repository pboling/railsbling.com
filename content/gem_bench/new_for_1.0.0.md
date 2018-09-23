+++
date = "2017-02-26T11:00:00-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "Gemfile Specs! New for gem_bench v1.0.2"
tags = [ "development", "ruby", "rails", "rubygems", "gem_bench", "release" ]
categories = [ "development", "tools", "Ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

# Find WAT Dragons! New for 1.0.0

Search the Ruby source code of all the gems loaded by your Gemfile for a specified regex, to find out which gems have wat DRAGONS.

Gem: "I have no wat DRAGONS!"
You: ❨╯°□°❩╯︵┻━┻

```
>> puts GemBench.find(look_for_regex: /wat/).starters.map {|gem| "#{gem.name} has wat DRAGONS at #{gem.stats}" }.join("\n")
[GemBench] Will search for gems in ["/Users/pboling/.rvm/gems/ruby-2.4.0@foss/gems", "/Users/pboling/.rvm/gems/ruby-2.4.0@global/gems", "/Users/pboling/.rvm/gems/ruby-2.4.0@foss/bundler/gems"]
[GemBench] Detected 11 loaded gems + 2 loaded gems which GemBench is configured to ignore.
byebug has wat DRAGONS at [["/Users/pboling/.rvm/gems/ruby-2.4.0@foss/gems/byebug-9.0.6/lib/byebug/commands/frame.rb", 954]]
=> nil
```

NOTE: The number (954, above) is not a line number. The file which contains the text `wat` was the 954th file evaluated, i.e. the number doesn't matter.
NOTE: This is a contrived example.  The occurrence of `wat` in byebug is meaningless: `byebug/commands/frame.rb:34` has `        if there is a front end also watching over things.`.  This is just an example!  You can find anything you want, perhaps even something important!

# What is gem_bench?

## Ruby Gemfile analysis.

`gem_bench` is for static Gemfile and installed gem library source code analysis.

`gem_bench` can also be used to trim down app load times by keeping your worst players on the bench.

Gem: "Put me in coach!"
You: ❨╯°□°❩╯︵┻━┻

[![Total Downloads](https://img.shields.io/gem/rt/gem_bench.svg)](https://github.com/pboling/gem_bench)
[![Downloads Today](https://img.shields.io/gem/rd/gem_bench.svg)](https://github.com/pboling/gem_bench)
[![Network](https://img.shields.io/github/forks/pboling/gem_bench.svg?style=social)](https://github.com/pboling/gem_bench/network)
[![Stars](https://img.shields.io/github/stars/pboling/gem_bench.svg?style=social)](https://github.com/pboling/gem_bench/stargazers)
[![Version](https://img.shields.io/gem/v/gem_bench.svg)](https://rubygems.org/gems/gem_bench)
[![Build](https://img.shields.io/travis/pboling/gem_bench.svg)](https://travis-ci.org/pboling/gem_bench)
[![Maintainability](https://api.codeclimate.com/v1/badges/fe504d4ab2fb77cecf7d/maintainability)](https://codeclimate.com/github/pboling/gem_bench/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/fe504d4ab2fb77cecf7d/test_coverage)](https://codeclimate.com/github/pboling/gem_bench/test_coverage)
[![Depfu](https://badges.depfu.com/badges/a34c123a78a86496bbc2163b801089dd/count.svg)](https://depfu.com/github/pboling/activerecord-tablefree?project_id=5613)
[![Open Source Helpers](https://www.codetriage.com/pboling/gem_bench/badges/users.svg)](https://www.codetriage.com/pboling/gem_bench)
[![Chat](https://img.shields.io/gitter/room/pboling/gem_bench.svg)](https://gitter.im/pboling/gem_bench)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
