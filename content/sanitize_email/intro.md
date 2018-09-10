+++
date = "2009-11-10T12:07:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "sanitize_email"
tags = [ "Development", "Ruby", "rails", "RubyGems", "sanitize_email" ]
categories = [ "Development", "tools", "Ruby" ]
series = [ "Toolchain" ]
type = "docs"

+++

## An Email Condom for your Ruby Server

[![Total Downloads](https://img.shields.io/gem/rt/sanitize_email.svg)](https://github.com/pboling/sanitize_email)
[![Downloads Today](https://img.shields.io/gem/rd/sanitize_email.svg)](https://github.com/pboling/sanitize_email)
[![Code Quality](https://img.shields.io/codeclimate/github/pboling/sanitize_email.svg)](https://codeclimate.com/github/pboling/sanitize_email)
[![Network](https://img.shields.io/github/forks/pboling/sanitize_email.svg?style=social)](https://github.com/pboling/sanitize_email/network)
[![Stars](https://img.shields.io/github/stars/pboling/sanitize_email.svg?style=social)](https://github.com/pboling/sanitize_email/stargazers)
[![Version](https://img.shields.io/gem/v/sanitize_email.svg)](https://rubygems.org/gems/sanitize_email)
[![Build](https://img.shields.io/travis/pboling/sanitize_email.svg)](https://travis-ci.org/pboling/sanitize_email)
[![Coverage Status](https://coveralls.io/repos/pboling/sanitize_email/badge.svg)](https://coveralls.io/r/pboling/sanitize_email)
[![Documentation](http://inch-ci.org/github/pboling/sanitize_email.svg)](http://inch-ci.org/github/pboling/sanitize_email)
[![Dependency Status](https://gemnasium.com/pboling/sanitize_email.svg)](https://gemnasium.com/pboling/sanitize_email)
[![Chat](https://img.shields.io/gitter/room/pboling/sanitize_email.svg)](https://gitter.im/pboling/sanitize_email)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

# sanitize_email

This gem allows you to override your mail delivery settings, globally or in a local context.  It is like a Ruby encrusted condom for your email server, just in case it decides to have intercourse with other servers via sundry mail protocols.

## Summary

It's particularly helpful when you want to prevent the delivery of email (e.g. in development/test environments) or alter the to/cc/bcc (e.g. in staging or demo environments) of all email generated from your application.

* compatible with Rails >= 3.X (since v1.0.5)
* compatible with any Ruby app with a Mail handler that uses the `register_interceptor` API (a la ActionMailer and Mail gems)
* configure it and forget it
* little configuration required
* solves common problems in ruby web applications that use email
* provides test helpers and spec matchers to assist with testing email content delivery

## Working Locally with Production Data

1. Have a production site with live data
2. Dump the live data and securely transfer it to another machine (e.g. rync -e ssh)
3. Import it into a development database
4. Test features which send out email (registration/signup, order placement, etc.)
5. Emails get sent (in real-life!) but to sanitized email recipients
6. Verify what they look like when sent
7. Iterate on email content design
8. No risk of emailing production addresses

## Re-routing Email on a Staging or QA Server

Another very important use case for me is to transparently re-route email generated from a staging or QA server to an appropriate person.  For example, it's common for us to set up a staging server for a client to use to view our progress and test out new features.  It's important for any email that is generated from our web application be delivered to the client's inbox so that they can review the content and ensure that it's acceptable.  Similarly, we set up QA instances for our own QA team and we use [rails-caddy](http://github.com/jtrupiano/rails-caddy) to allow each QA person to configure it specifically for them.

## Testing Email from a Hot Production Server

If you install this gem on a production server (which I don't always do), you can load up script/console and override the to/cc/bcc on all emails for the duration of your console session.  This allows you to poke and prod a live production instance, and route all email to your own inbox for inspection.  The best part is that this can all be accomplished without changing a single line of your application code.

## Using with a test suite as an alternative to the heavy email_spec

[email_spec](https://github.com/bmabey/email-spec) is a great gem, with awesome rspec matchers and helpers, but it has an undeclared dependency on ActionMailer. Sad face.

SanitizeEmail comes with some lightweight RspecMatchers covering most of what email_spec can do.  It will help you test email functionality.  It is useful when you are creating a gem to handle email features, or are writing a simple Ruby script, and don't want to pull in le Rails.  SanitizeEmail has no dependencies.  Your Mail system just needs to conform to the `register_interceptor` API.

## Install Like a Boss

In Gemfile:

```ruby
gem 'sanitize_email'
```

Then:

```bash
$ bundle install
```

## Setup with Ruby

*keep scrolling for Rails, but read this for a better understanding of Magic*

There are four ways SanitizeEmail can be turned on; in order of precedence they are:

1. Only useful for local context.  Inside a method where you will be sending an email, set `SanitizeEmail.force_sanitize = true` just prior to delivering it.  Also useful in the console.

    ```ruby
    SanitizeEmail.force_sanitize = true # by default it is nil
    ```

2. If SanitizeEmail seems to not be sanitizing you have probably not registered the interceptor.  SanitizeEmail tries to do this for you. *Note*: If you are working in an environment that has a Mail or Mailer class that uses the register_interceptor API, the interceptor will already have been registered by SanitizeEmail (however, note lack of `:engage => true`):

    ```ruby
    Mail.register_interceptor(SanitizeEmail::Bleach.new(:engage => true)) # by default :engage is nil
    ```

    Without :engage => true the interceptor is inactive, and will require engaging via one of the other methods.

    ```ruby
    Mail.register_interceptor(SanitizeEmail::Bleach.new)
    ```
    As an example you could do the following to engage SanitizeEmail:

    ```ruby
    SanitizeEmail::Config.configure {|config| config[:engage] = true }
    ```

3. If you don't need to compute anything, then don't use this option, go with the next option.

    ```ruby
    SanitizeEmail::Config.configure {|config| config[:activation_proc] = Proc.new { true } } # by default :activation_proc is false
    ```

4. This will turn it on.  Period.

    ```ruby
    SanitizeEmail::Config.configure {|config| config[:engage] = true } # by default :engage is nil
    ```

### Notes

Number 1, above, is the method used by the SanitizeEmail.sanitary block.
If installed but not configured, sanitize_email DOES NOTHING.  Until configured the defaults leave it turned off.

### Troubleshooting

IMPORTANT: You may need to setup your own register_interceptor.  If sanitize_email doesn't seem to be working for you find your Mailer/Mail class and try this:

```ruby
Mail.register_interceptor(SanitizeEmail::Bleach.new(:engage => true))
```

If that causes an error you will know why sanitize_email doesn't work.
Otherwise it will start working according to the rest of the configuration.

## Setup With Rails

Create an initializer, if you are using rails, or otherwise configure:

```ruby
SanitizeEmail::Config.configure do |config|
  config[:sanitized_to] =         'to@sanitize_email.org'
  config[:sanitized_cc] =         'cc@sanitize_email.org'
  config[:sanitized_bcc] =        'bcc@sanitize_email.org'
  # run/call whatever logic should turn sanitize_email on and off in this Proc:
  config[:activation_proc] =      Proc.new { %w(development test).include?(Rails.env) }
  config[:use_actual_email_prepended_to_subject] = true         # or false
  config[:use_actual_environment_prepended_to_subject] = true   # or false
  config[:use_actual_email_as_sanitized_user_name] = true       # or false
end
```

Keep in mind, this is ruby (and possibly rails), so you can add conditionals or utilize different environment.rb files to customize these settings on a per-environment basis.

But wait there's more:

Let's say you have a method in your model that you can call to test the signup email. You want to be able to test sending it to any user at any time... but you don't want the user to ACTUALLY get the email, even in production. A dilemma, yes?  Not anymore!

To override the environment based switch use `force_sanitize`, which is normally `nil`, and ignored by default. When set to `true` or `false` it will turn sanitization on or off:

```ruby
  SanitizeEmail.force_sanitize = true
```

There are also two methods that take a block and turn SanitizeEmail on or off:

Regardless of the Config settings of SanitizeEmail you can do a local override to force unsanitary email in any environment.

```ruby
  SanitizeEmail.unsanitary do
    Mail.deliver do
      from      'from@example.org'
      to        'to@example.org' # Will actually be sent to the specified address, not sanitized
      reply_to  'reply_to@example.org'
      subject   'subject'
    end
  end
```

Regardless of the Config settings of SanitizeEmail you can do a local override to send sanitary email in any environment.
You have access to all the same configuration options in the parameter hash as you can set in the actual
`SanitizeEmail.configure` block.

```ruby
  SanitizeEmail.sanitary({:sanitized_to => 'boo@example.com'}) do # these config options are merged with the globals
    Mail.deliver do
      from      'from@example.org'
      to        'to@example.org' # Will actually be sent to the override addresses, in this case: boo@example.com
      reply_to  'reply_to@example.org'
      subject   'subject'
    end
  end
```

## Use sanitize_email in your test suite!

### rspec

In your `spec_helper.rb`:

```ruby
require 'sanitize_email'
# rspec matchers are *not* loaded by default in sanitize_email, as it is not primarily a gem for test suites.
require 'sanitize_email/rspec_matchers'

SanitizeEmail::Config.configure do |config|
  config[:sanitized_to] =         'sanitize_email@example.org'
  config[:sanitized_cc] =         'sanitize_email@example.org'
  config[:sanitized_bcc] =        'sanitize_email@example.org'
  # run/call whatever logic should turn sanitize_email on and off in this Proc.
  # config[:activation_proc] =      Proc.new { true }
  # Since this configuration is *inside* the spec_helper, it might be assumed that we always want to sanitize.  If we don't want to it can be easily manipulated with SanitizeEmail.unsanitary and SanitizeEmail.sanitary block helpers.
  # Thus instead of using the Proc (slower) we just engage it always:
  config[:engage] = true
  config[:use_actual_email_prepended_to_subject] = true         # or false
  config[:use_actual_environment_prepended_to_subject] = true   # or false
  config[:use_actual_email_as_sanitized_user_name] = true       # or false
end

# If your mail system is not one that sanitize_email automatically configures an interceptor for (ActionMailer, Mail) then you will need to do the equivalent for whatever Mail system you are using:
# Mail.register_interceptor(SanitizeEmail::Bleach.new)

RSpec.configure do |config|
  # ...
  # From sanitize_email gem
  config.include SanitizeEmail::RspecMatchers
end

context "an email test" do
  subject { Mail.deliver(@message_hash) }
  it { should have_to "sanitize_email@example.org" }
end
```

#### have_* matchers

These will look for an email address in any of the following

```ruby
:from, :to, :cc, :bcc, :subject, :reply_to
```

Example:

```ruby
context "the subject line must have the email address sanitize_email@example.org" do
  subject { Mail.deliver(@message_hash) }
  it { should have_subject "sanitize_email@example.org" }
end
```

#### be_* matchers

These will look for a matching string in any of the following

```ruby
:from, :to, :cc, :bcc, :subject, :reply_to
```

Example:

```ruby
context "the subject line must have the string 'foobarbaz'" do
  subject { Mail.deliver(@message_hash) }
  it { should be_subject "foobarbaz" }
end
```

#### have_to_username matcher

The `username` in the `:to` field is when the `:to` field is formatted like this:

`Peter Boling <sanitize_email@example.org>`

Example:

```ruby
context "the to field must have the username 'Peter Boling'" do
  subject { Mail.deliver(@message_hash) }
  it { should have_to_username "Peter Boling" }
end
```

### non-rspec (Test::Unit, mini-test, etc)

In your setup file:

```ruby
require 'sanitize_email'
# test helpers are *not* loaded by default in sanitize_email, as it is not primarily a gem for test suites.
require 'sanitize_email/test_helpers'

SanitizeEmail::Config.configure do |config|
  config[:sanitized_to] =         'sanitize_email@example.org'
  config[:sanitized_cc] =         'sanitize_email@example.org'
  config[:sanitized_bcc] =        'sanitize_email@example.org'
  # run/call whatever logic should turn sanitize_email on and off in this Proc.
  # config[:activation_proc] =      Proc.new { true }
  # Since this configuration is *inside* the spec_helper, it might be assumed that we always want to sanitize.  If we don't want to it can be easily manipulated with SanitizeEmail.unsanitary and SanitizeEmail.sanitary block helpers.
  # Thus instead of using the Proc (slower) we just engage it always:
  config[:engage] = true
  config[:use_actual_email_prepended_to_subject] = true         # or false
  config[:use_actual_environment_prepended_to_subject] = true   # or false
  config[:use_actual_email_as_sanitized_user_name] = true       # or false
end

# If your mail system is not one that sanitize_email automatically configures an interceptor for (ActionMailer, Mail) then you will need to do the equivalent for whatever Mail system you are using:
# Mail.register_interceptor(SanitizeEmail::Bleach.new)

# You need to know what to do here... somehow get the methods into rhw scope of your tests.
# Something like this maybe?
include SanitizeEmail::TestHelpers
# Look here to see what it gives you:
# https://github.com/pboling/sanitize_email/blob/master/lib/sanitize_email/test_helpers.rb
```

## Deprecations

Sometimes things get deprecated (meaning they still work, but are noisy about it).  If this happens to you, and you like your head in the sand, call this number:

```ruby
SanitizeEmail::Deprecation.deprecate_in_silence = true
```

## Authors

Peter Boling is the original author of the code, and current maintainer of both the rails 2 and rails 3 development tracks.
John Trupiano did the initial gemification and some refactoring.

## Contributors

See the [Network View](https://github.com/pboling/sanitize_email/network) and the [CHANGELOG](https://github.com/pboling/sanitize_email/blob/master/CHANGELOG.md)

## How you can help!

Take a look at the `reek` list which is the file called `REEK` and stat fixing things.  Once you complete a change, run the tests:

`bundle exec rake test:all`

If the tests pass refresh the `reek` list:

`bundle exec reek > REEK`

Follow the instructions for "Contributing" below.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
6. Create new Pull Request

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
spec.add_dependency 'sanitize_email', '~> 1.1'
```

## References

* [Source Code](http://github.com/pboling/sanitize_email)
* [Gem Release Announcement](http://blog.smartlogicsolutions.com/2009/04/25/reintroducing-sanitize_email-work-with-production-email-without-fear/)
* [Peter's Original Writeup](http://galtzo.blogspot.com/2008/11/sanitize-email-never-worry-about.html)
* [Using sanitize_email to Preview HTML Emails Locally](http://blog.smartlogicsolutions.com/2009/04/30/using-sanitize-email-to-preview-html-emails-locally/)

## Legal

* MIT License - See LICENSE file in this project
* Copyright (c) 2008-2015 [Peter H. Boling][peterboling] of [Rails Bling][railsbling]
* Copyright (c) 2009 [John Trupiano](http://smartlogicsolutions.com/wiki/John_Trupiano) of [SmartLogic Solutions, LLC](http://www.smartlogicsolutions.com)

[semver]: http://semver.org/
[pvc]: http://docs.rubygems.org/read/chapter/16#page74
[railsbling]: http://www.railsbling.com
[peterboling]: http://www.peterboling.com
[documentation]: http://rdoc.info/github/pboling/sanitize_email/frames
[homepage]: https://github.com/pboling/sanitize_email
