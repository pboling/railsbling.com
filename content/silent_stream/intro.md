+++
date = "2018-09-23T11:00:00-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "Introducing silent_stream"
tags = [ "development", "ruby", "rails", "rubygems", "silent_stream" ]
categories = [ "development", "tools", "Ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

## ActiveSupport's Stream Silencing - Without ActiveSupport

[![Total Downloads](https://img.shields.io/gem/rt/silent_stream.svg)](https://github.com/pboling/silent_stream)
[![Downloads Today](https://img.shields.io/gem/rd/silent_stream.svg)](https://github.com/pboling/silent_stream)
[![Network](https://img.shields.io/github/forks/pboling/silent_stream.svg?style=social)](https://github.com/pboling/silent_stream/network)
[![Stars](https://img.shields.io/github/stars/pboling/silent_stream.svg?style=social)](https://github.com/pboling/silent_stream/stargazers)
[![Version](https://img.shields.io/gem/v/silent_stream.svg)](https://rubygems.org/gems/silent_stream)
[![Build](https://img.shields.io/travis/pboling/silent_stream.svg)](https://travis-ci.org/pboling/silent_stream)
[![Maintainability](https://api.codeclimate.com/v1/badges/ced7e39984dd9c27c528/maintainability)](https://codeclimate.com/github/pboling/silent_stream/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ced7e39984dd9c27c528/test_coverage)](https://codeclimate.com/github/pboling/silent_stream/test_coverage)
[![Depfu](https://badges.depfu.com/badges/6633827ecc1ad3b5dd749b4ac822347b/count.svg)](https://depfu.com/github/pboling/silent_stream?project_id=5828)
[![Open Source Helpers](https://www.codetriage.com/pboling/silent_stream/badges/users.svg)](https://www.codetriage.com/pboling/silent_stream)
[![Chat](https://img.shields.io/gitter/room/pboling/silent_stream.svg)](https://gitter.im/pboling/silent_stream)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

SilentStream is an extraction of some parts of ActiveSupport's Kernel Reporting Core Extentions.

Since July 2014 `silence_stream`, `silence_stderr`, `capture`, `silence`, and `quietly` have been deprecated because they are not thread safe.  See that discussion in the [PR where it all went down](https://github.com/rails/rails/pull/13392). I rely on them a lot in *single threaded* code, and so I plan to keep them alive.  With the exception of `silence`, which was just an alias of `capture`.

This gem was taken out of Rails but it is *not* Rails dependent.  The extraction was total (**even the tests**!), and this is now a pure Ruby library, which can be used in any Ruby project without encumbrances.

## NOTE

One aspect of what this gem provides can be achieved with the Rails' built-in [`LoggerSilence`](https://github.com/rails/rails/blob/5-2-stable/activesupport/lib/active_support/logger_silence.rb), which is thread safe.  You will have to decide what is right for you!

## Doing a Rails <= 4 to Rails >= 5 Upgrade?

The reason for not keeping `silence` as it was in Rails 4, i.e. an alias of `capture`, is that the just mentioned `LoggerSilence` now uses this term, and it is shipping with Rails 5. I don't want to make this gem incompatible with Rails 5, so you will have to convert Rails <= 4 implementations that utilize `silence` over to `capture` when using this gem.  One further point of difference is this gem does not add the methods to `Kernel` or `Object`.  You can do that if you like via `include`.  By default this gem does not pollute anything, so you will need to `include SilentStream` in any class using these methods.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'silent_stream'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install silent_stream

## Usage

Usage:

```ruby
class Bogosity
  include SilentStream # allows use at instance or class level

  def silent
    silence_all(true) do
      puts "play that funky music"
      Rails.logger.info "git jiggy with it"
    end
  end
  class << self
    def noise
      silence_all(false) do
        puts "play that funky music"
        Rails.logger.info "git jiggy with it"
      end
    end
  end
end
```
And run
```
>> Bogosity.new.silent # has no output
=> nil
>> Bogosity.noise # is noisy
play that funky music
=> nil
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pboling/silent_stream.

## Code of Conduct

Everyone interacting in the AnonymousActiveRecord project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pboling/silent_stream/blob/master/CODE_OF_CONDUCT.md).

## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][semver].
Violations of this scheme should be reported as bugs. Specifically,
if a minor or patch version is released that breaks backward
compatibility, a new version should be immediately released that
restores compatibility. Breaking changes to the public API will
only be introduced with new major versions.

As a result of this policy, you can (and should) specify a
dependency on this gem using the [Pessimistic Version Constraint][pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency 'silent_stream', '~> 1.0'
```

## License

* Copyright (c) 2018 [Peter H. Boling][peterboling] of [Rails Bling][railsbling]
