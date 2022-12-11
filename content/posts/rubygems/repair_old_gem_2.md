+++
date = "2022-05-05T09:04:22+07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
hero = "images/posts/writing/jon-tyson-rXi6VEpoSqQ-unsplash-1920-1095-crop.png"
title = "How to Repair an Old Gem (Part 2) - Bundler"
tags = [ "development", "ruby", "rubygems", "floss", "bundler" ]
categories = [ "development", "tools", "ruby", "maintenance", "bundler" ]
series = [ "RubyGemRepair" ]

[menu]
[menu.sidebar]
name = "Repair Bundler (Part 2)"
identifier = "repair_old_gem_2"
parent = "rubygems"
weight = 12

+++

Checkout [Part 1](/posts/rubygems/repair_old_gem_1) of the series first!

When I started working on this `os` repair project a fresh checkout of the source code would not `bundle install`.

I was able to fix the problem, but these issues are like peeling an onion.
After fixing bundler the tests would not run, and how can you merge a PR if the test suite hasn't been run?

The critical change for bundler is removing the `os` gem from being a dependency of the `os` gem.
```ruby
# Removed:
s.add_runtime_dependency(%q<os>.freeze, [">= 0"])
```

The critical change for RSpec is constraining the version to the last known good state,
which thankfully was recorded in the `Gemfile.lock`.

```ruby
# Locked down to patch level:
s.add_dependency(%q<test-unit>.freeze, ["~> 3.2.0"])
s.add_dependency(%q<rspec>.freeze, ["~> 2.5.0"])
```

Additionally it fixes two broken tests, where it is clear the author and I have different platforms,
and so we hit different paths in the test code.

Bundle fixed, and tests passing!

Check out the [pull request](https://github.com/rdp/os/pull/59)
and give it a thumbs up or a heart if you are feeling generous!

Stay tuned for further posts in this series!

> [Hero image (cropped)](https://unsplash.com/photos/rXi6VEpoSqQ) by [Jon Tyson](https://unsplash.com/@jontyson)
