+++
date = "2022-12-11T08:22:22+07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
hero = "images/posts/writing/jon-tyson-rXi6VEpoSqQ-unsplash-1920-1095-crop.png"
title = "How to Repair an Old Gem (Part 3) - Upgrade RSpec"
tags = [ "development", "ruby", "rubygems", "floss", "rspec" ]
categories = [ "development", "tools", "ruby", "maintenance", "rspec" ]
series = [ "RubyGemRepair" ]

[menu]
[menu.sidebar]
name = "Upgrade RSpec (Part 3)"
identifier = "repair_old_gem_3"
parent = "rubygems"
weight = 12

+++

Checkout [Part 1](/posts/rubygems/repair_old_gem_1), and [Part 2](/posts/rubygems/repair_old_gem_2) of the series first!

Now that we can bundle install, and have a passing test suite with a very old version of RSpec, we need to upgrade RSpec.

This is most easily done with a tool called [`transpec`](https://github.com/yujinakayama/transpec).

Before we can setup `transpec` we need to upgrade to a minimum version of Ruby.  Some generic requirements are:
- RSpec must be at least 2.14 or later.
- RSpec must be less than version 3.

First we'll try version 2.99, as it was intended as a transitional version of RSpec between 2 and 3.

Initially the gemspec's dependencies are strangely encoded due to a legacy rubygems issue that is no longer relevant,
not even on Ruby 1.8.7.  We start with this:
```ruby
  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["~> 0.8"])
      s.add_development_dependency(%q<test-unit>.freeze, ["~> 3.5"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.99"])
    else
      s.add_dependency(%q<rake>.freeze, ["~> 0.8"])
      s.add_dependency(%q<test-unit>.freeze, ["~> 3.5"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.99"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["~> 0.8"])
    s.add_dependency(%q<test-unit>.freeze, ["~> 3.5"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.99"])
  end
```
We'll replace the entire block with:
```ruby
  s.add_development_dependency(%q<rake>.freeze, ["~> 0.8"])
  s.add_development_dependency(%q<test-unit>.freeze, ["~> 3.5"])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 2.99"])
```

We `bundle install`.

We also modify the RSpec config to work with both types of expectation syntaxes (should and assert).
```ruby
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :should
  end

  config.expect_with :stdlib # assert syntax
end
```

Then commit the changes, because `transpec` requires a clean git repo.

But we run into problems with our version of bundler.
```shell
$ transpec                              
You must use Bundler 2 or greater with this lockfile.
```
This error is confusing, as what it means is that transpec is trying to run with Bundler v1,
but the Gemfile in our project requires v2. Transpec will not work with bundler v2, so we have to make more adjustments.
Thanks to [kaiwren](https://github.com/yujinakayama/transpec/pull/138) for figuring this out (please upvote the PR)!
```shell
$ bundle _1.17.3_ install
```
Once again, commit everything to get back to a clean slate in git.
Then `transpec` should work, and it does!
```
$ transpec               
Copying the project for dynamic analysis...
Running dynamic analysis with command "bundle exec rspec"...

OS provides access to to underlying config values
  #config, supplys the CONFIG hash
.    should supply 'host_os'
.    should be a kind of Hash
.    should supply 'host_cpu'

... etc

Summary:

8 conversions
  from: it { should ... }
    to: it { is_expected.to ... }
7 conversions
  from: it { should_not ... }
    to: it { is_expected.not_to ... }
6 conversions
  from: obj.should
    to: expect(obj).to
5 conversions
  from: obj.stub!(:message)
    to: allow(obj).to receive(:message)
4 conversions
  from: obj.stub(:message)
    to: allow(obj).to receive(:message)
3 conversions
  from: == expected
    to: eq(expected)
2 conversions
  from: pending
    to: skip
1 conversion
  from: obj.should_receive(:message)
    to: expect(obj).to receive(:message)
1 conversion
  from: obj.should_receive(:message).and_return
    to: obj.should_receive(:message)
1 conversion
  from: obj.should_receive(:message).any_number_of_times
    to: allow(obj).to receive(:message)
```
Now we re-run specs, to ensure the translation didn't break anything.

Lulz, it broke so much.  But we're well on our way to having an upgraded test suite.

Let's fix noisy deprecation warnings.
```
:stdlib is deprecated. Use :test_unit or :minitest instead. Called from /Users/pboling/src/hub/moss/spec/config/rspec/rspec_core.rb:16:in `block in <top (required)>'.
```
The fix:
```ruby
  config.expect_with :test_unit
```
Running tests again, and all deprecations are fixed!  We still have lots of failures though, all taking the form of:
```
Failure/Error: it { is_expected.to be_linux }
       only the `receive` matcher is supported with `expect(...).to`, but you have provided: #<RSpec::Matchers::BuiltIn::BePredicate:0x00007fc3f686bb38>
```
This is a matcher issue, and we'll want our "fixed" matchers to work on current latest version of RSpec,
so let's upgrade to latest next, and then fix the matchers after.
We'll need RSpec 3, but which version exactly? We'll usee `bundle outdated` to find out,
but first we need to delete the Gemfile.lock and run `bundle update` to get back to a modern bundler.
```
rm Gemfile.lock
bundle update
bundle outdated
...
Gem                 Current  Latest  Requested  Groups
rake                0.9.6    13.0.6  ~> 0.8     development
rspec               2.99.0   3.12.0  ~> 2.99    development
rspec-core          2.99.2   3.12.0
rspec-expectations  2.99.2   3.12.0
rspec-mocks         2.99.4   3.12.1
```

Addressing each of these... the `rake` gem's [version will be determined](https://rubygems.org/gems/rake/versions) by which version of Ruby we want to support.
Since `os` has never declared a Ruby version constraint, and given the age of the code, it should be assumed to be 1.8.7.

| Rake Version Constraint | Gemspec Ruby Version Constraint |
|-------------------------|---------------------------------|
| `~> 10.5` 👈            | `>= 1.8.7` 👈                   |
| `~> 11.3`               | `>= 1.9.3`                      |
| `~> 12.3`               | `>= 2.0.0`                      |
| `~> 13.0`               | `>= 2.2.0`                      |

So we can update that, and `bundle install` again.
```ruby
s.add_development_dependency(%q<rake>.freeze, ["~> 10.5"])
```

Specs are still failing same as before, so moving on to upgrading the outdated `rspec` gems:
```rspec
s.add_development_dependency(%q<rspec>.freeze, ["~> 3.12"])
```
And `bundle install` again, and the same 22 of 32 specs are failing as before, so let's look closer at the failure.
It should be clear why we upgraded first.  The problem is the same,
but the newer version of RSpec has dramatically improved the developer experience!
Compare what the error was before, on RSpec v2.99:
```ruby
only the `receive` matcher is supported with `expect(...).to`, but you have provided: #<RSpec::Matchers::BuiltIn::BePredicate:0x00007fc3f686bb38>
```
Now, on RSpec v3.12:
```ruby
undefined method `expect' for #<RSpec::ExampleGroups::ForLinuxUbuntuUbuntu1004LTS::OS:0x00007fceb084c570>
```
So the issue is simply that we need to change the RSpec expect syntax to the one `transpec` used:
```ruby
  config.expect_with :rspec do |c|
    c.syntax = :expect # 👈 Change from :should to :expect
  end

  config.expect_with :test_unit # Some tests still use this syntax, which is fine.
```
```
$ bundle exec rspec
...
36 examples, 0 failures
```
RSpec test suite upgraded!

Stay tuned for further posts in this series!

> [Hero image (cropped)](https://unsplash.com/photos/rXi6VEpoSqQ) by [Jon Tyson](https://unsplash.com/@jontyson)
