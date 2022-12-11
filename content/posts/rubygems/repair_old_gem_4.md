+++
date = "2022-12-11T22:27:22+07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
hero = "images/posts/writing/jon-tyson-rXi6VEpoSqQ-unsplash-1920-1095-crop.png"
title = "How to Repair an Old Gem (Part 4) - Upgrade Autotest"
tags = [ "development", "ruby", "rubygems", "floss", "rspec" ]
categories = [ "development", "tools", "ruby", "maintenance", "rspec" ]
series = [ "RubyGemRepair" ]

[menu]
[menu.sidebar]
name = "Upgrade Autotest (Part 4)"
identifier = "repair_old_gem_4"
parent = "rubygems"
weight = 14

+++

Checkout [Part 1](/posts/rubygems/repair_old_gem_1),
[Part 2](/posts/rubygems/repair_old_gem_2), and
[Part 3](/posts/rubygems/repair_old_gem_3) of the series first!

The ancient, venerable, and useful `autotest` gem died, but was reborn as `rspec-autotest`.
Let's migrate the library to use it!

We still use the old `.autotest` hook file, but we replace the old contents:
```ruby
# autotest config for rspec
# see: https://github.com/rspec/rspec/wiki/autotest
Autotest.add_hook(:initialize) {|at|
  at.add_exception %r{^\.git}  # ignore Version Control System
  at.add_exception %r{^pkg}  # ignore gem pkg dir
  #  at.add_exception %r{^./tmp}  # ignore temp files, lest autotest will run again, and again...
  #  at.clear_mappings         # take out the default (test/test*rb)
  ## include specs
  at.add_mapping(%r{^lib/.*\.rb$}) {|f, _|
    Dir['spec/**/*_spec.rb']
  }
  nil
}
```
with new contents:
```ruby
require "autotest/bundler"
```

But it won't work, because in [Part 3](/posts/rubygems/repair_old_gem_3) we upgraded from RSpec v2 to v3,
but we left v2 installed, albeit unused.  Autotest will not work if RSpec [v2 and v3 are both installed](https://github.com/rspec/rspec-autotest#autotest-style-autotestrspec_rspec2-doesnt-seem-to-exist-aborting).
So we uninstall the old RSpec gems.
Use `gem list rspec` to see all the gems, and the versions, you need to clear out:
```
$ gem list rspec

*** LOCAL GEMS ***

rspec (3.12.0, 3.11.0, 2.99.0, 2.5.0)
rspec-autotest (1.0.2)
rspec-block_is_expected (1.0.2)
rspec-core (3.12.0, 3.11.0, 2.99.2, 2.5.2)
rspec-expectations (3.12.0, 3.11.1, 3.11.0, 2.99.2, 2.5.0)
rspec-mocks (3.12.1, 3.11.1, 2.99.4, 2.5.0)
rspec-pending_for (0.1.16)
rspec-stubbed_env (1.0.0)
rspec-support (3.12.0, 3.11.1, 3.11.0)
rubocop-rspec (1.41.0)
```
And then start uninstalling
```
$ gem uninstall rspec

Select gem to uninstall:
1. rspec-2.5.0
2. rspec-2.99.0
3. rspec-3.11.0
4. rspec-3.12.0
5. All versions
> 1
Successfully uninstalled rspec-2.5.0
```
And repeat for all but the gem version we need.
And repeat for each of the various RSpec-family gems, such as `rspec-core`.
```
$ gem uninstall rspec-core

Select gem to uninstall:
 1. rspec-core-2.5.2
 2. rspec-core-2.99.2
 3. rspec-core-3.11.0
 4. rspec-core-3.12.0
 5. All versions
> 1
Successfully uninstalled rspec-core-2.5.2
```
After much uninstalling we get:
```
$ gem list rspec               

*** LOCAL GEMS ***

rspec (3.12.0)
rspec-autotest (1.0.2)
rspec-block_is_expected (1.0.2) # 👈 Part of my suite of RSpec extensions! Check it out!
rspec-core (3.12.0)
rspec-expectations (3.12.0)
rspec-mocks (3.12.1)
rspec-pending_for (0.1.16) # 👈 Part of my suite of RSpec extensions! Check it out!
rspec-stubbed_env (1.0.0) # 👈 Part of my suite of RSpec extensions! Check it out!
rspec-support (3.12.0)
rubocop-rspec (1.41.0)
```
It still won't work though, becuase the `rspec-autotest` gem doesn't include an `autotest` executable.  Several gems provide a compatible `autotest` command.

> rspec-autotest provides integration between autotest and RSpec; Autotest is not included in this gem and can be installed via the autotest-standalone or zentest gems.

Choose between the options: `autotest-standalone` hasn't been [touched since 2012](https://rubygems.org/gems/autotest-standalone),
and `zentest` is more actively maintained...
However, `ZenTest` will be dropping the `autotest` feature from the next release,
and instructs people to switch to `minitest-autotest`.
However, `minitest-autotest` has zero RSpec integration (no surprise there),
so we try the very old `autotest-standalone`, and discover that it requires RSpec v2, and doesn't support RSpec v3.
So, we must drop `autotest` altogether, and switch to `guard` if we want autotesting with RSpec v3.
```ruby
  s.add_development_dependency(%q<guard-rspec>.freeze, ["~> 4.7"])
```
Now `bundle update`.
Then create a new config file at `Guardfile`:
```ruby
guard :rspec, cmd: "bundle exec rspec" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # Feel free to open issues for suggestions and improvements

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { "#{rspec.spec_dir}/config" }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)
end
```
Now try `bundle exec guard`!
```
$ bundle exec guard
```
Hit enter to run all specs.

Delete the various `autotest` related files...

`autotest` has been ripped out, and replaced with `guard-rspec`!

Check out the [pull request](https://github.com/rdp/os/pull/71)
and give it a thumbs up or a heart if you are feeling generous!

Stay tuned for further posts in this series!

> [Hero image (cropped)](https://unsplash.com/photos/rXi6VEpoSqQ) by [Jon Tyson](https://unsplash.com/@jontyson)
