+++
date = "2017-06-02T11:00:00-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "Gemfile Specs! New for gem_bench v1.0.2"
tags = [ "development", "ruby", "rails", "rubygems", "gem_bench", "release" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

# Gemfile Specs! New for 1.0.2

Version constraints are important.  Give the Gemfile some love in your CI build

Create a `spec/gemfile_spec.rb` like:
```ruby
Rspec.describe "Gemfile" do
  it("has version constraint on every gem") do
    requirements = GemBench::StrictVersionRequirement.new({verbose: false})
    expect(requirements.list_missing_version_constraints).to eq([])
  end
end
```

Then your build will fail as soon as a gem is added without a proper constraint:

```
Failures:

1) Gemfile has version constraint on every gem
Failure/Error: expect(requirements.list_missing_version_constraints).to eq([])

  expected: []
       got: ["puma"]

  (compared using ==)
# ./spec/gemfile_spec.rb:7:in `block (2 levels) in <top (required)>'
```

For `:git`/`:github` sources, `:ref` and `:tag` are considered as "constraints", while `:branch` is not, because branches may be a moving target, and this gem aims to make Gemfiles production-ready.
For string version constraints anything is allowed (e.g. `'~> 1.0'`), as it assumes the constraint placed is well considered.

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
