+++
date = "2022-05-05T06:57:22+07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
hero = "images/posts/writing/jon-tyson-rXi6VEpoSqQ-unsplash-1920-1095-crop.png"
title = "How to Repair an Old Gem (Part 1)"
tags = [ "development", "ruby", "rubygems", "floss" ]
categories = [ "development", "ruby", "maintenance" ]
series = [ "RubyGemRepair" ]

[menu]
[menu.sidebar]
name = "Repair Old Gem (Part 1)"
identifier = "repair_old_gem_1"
parent = "rubygems"
weight = 11

+++

I want to build out new features in my rspec-pending_for gem,
and to do that I want to use the `os` gem, which is a de-facto standard.
Unfortunately the `os` gem has been in a state of extreme disrepair for some time.
The author does respond on the issue tracker, and merges pull requests, but is no longer actively working on the gem.
As it stands the `os` gem has a number critical issues and I have documented them extensively.

This is the first post in a series of posts where I will document my work to modernize the `os` gem.

My fork is using a different name, `moss`, because that's the name I'll use if I end up needing to fork
in order to release the fixes to RubyGems.  For some time it appeared that would be the case,
but the author has since been a bit more responsive, so the hard fork might be avoidable.

What follows is my initial analysis of the state of the `os` gem from a comment I left on [May 5, 2022](https://github.com/rdp/os/issues/27#issuecomment-1118035118).

> Begin
> > Quote

[@ioquatix](https://github.com/ioquatix) is correct, a class at the top-level can cause a number of problems, and is against standard convention for good reasons.  I've made the mistake before, and vowed never to repeat it.

# Reverse Dependencies

This gem has many [reverse dependencies](https://rubygems.org/gems/os/reverse_dependencies), totalling hundreds of millions of downloads, and, given the nature of software, many of those mature, stable packages would have little reason to be updated other than to pull in a major version upgrade to this gem.

This gem should not make a change from top-level class to top-level module without a major version bump, [as it would be an "incompatible API change"](https://semver.org/spec/v2.0.0.html) IMO.  If it were to happen it would result in "chained upgrade hell", fracturing the Ruby ecosystem a bit like is happening right now between Faraday v1 and Faraday v2.

# A Version Split?

In a version split a project's dependencies either need to all be updated to work with `v.<next>`, or they all have to remain stuck at `v.<current>` (forever).  Many dependencies are not being maintained any more which has resulted in a great deal of effort expended on the part of too few people.

As a taste of why a version split outcome is undesireable, here are some projects affected by the Faraday version split: [elasticsearch](https://github.com/elastic/elastic-transport-ruby/pull/27), [discourse](https://github.com/discourse/discourse/pull/16008), [oauth2](https://github.com/oauth-xx/oauth2/issues/559), [danger](https://github.com/danger/danger/issues/1349), and _all their dependencies_.  Danger, used by thousands of projects, is at risk, as many major projects are removing it so they can upgrade to Faraday 2, including [Github's oktokit](https://github.com/octokit/octokit.rb/pull/1413) and [Slack's ruby client](https://github.com/slack-ruby/slack-ruby-client/issues/399).

# What is the state of this library?

As an outside observer who has never before interacted with it, or even used it...

- The author/maintainer hasn't changed much in years, which, as I argued at the beginning, may be for the best!
- Deep reverse dependency tree, and changes have an extensive ripple effect
- [#58](https://github.com/rdp/os/issues/58) - Hasn't kept up with latest Rubygem best practices
- [#57])https://github.com/rdp/os/issues/57) - There are no integrations configured for CI, or any other code analysis tools
- [#61](https://github.com/rdp/os/issues/61) - Missing `OS::VERSION` constant
- [#62](https://github.com/rdp/os/issues/62) - Missing `spec.required_ruby_version` in gemspec
- [#56](https://github.com/rdp/os/issues/56) - It is packaged and released by Jeweler, a gem packaging tool that died many years ago due to being seriously broken, as evidenced by the hilarious comment in this gem's [`Rakefile`](https://github.com/rdp/os/blob/master/Rakefile#L3)
```
# HOW TO DEPLOY
# bump VERSION file manually
# rake release
# Don't forget to run rake gemspec with each release! ... I think...or rake release might be same thing
# then manually edit os.gemspec remove duplicatee rspecs, circular dependency on os? HUH?
# # then  gem build os.gemspec
# rake build doesn't work???
# sooo...
# ...gem push os-1.1.2.gem
```
- [#55](https://github.com/rdp/os/issues/55) - Current master can't do `bundle install`:
```
❯ bundle install
Fetching bundler 2.1.4
Installing bundler 2.1.4
Fetching gem metadata from http://rubygems.org/.......
Resolving dependencies...
Your bundle requires gems that depend on each other, creating an infinite loop. Please remove gem 'os' and try again.
```
- [#60](https://github.com/rdp/os/issues/60) - Test suite doesn't pass on MacOS
```
..................F..F..............

Failures:

  1) OS has working cpu count method
     Failure/Error: assert (cpu_count & (cpu_count - 1)) == 0 # CPU count is normally a power of 2
     Test::Unit::AssertionFailedError:
       <false> is not true.
     # ./spec/os_spec.rb:124:in `block (2 levels) in <top (required)>'

  2) OS should provide a path to directory for application config
     Failure/Error: assert OS.app_config_path('appname') == '/home/xdg/Library/Application Support/appname'
     Test::Unit::AssertionFailedError:
       <false> is not true.
     # ./spec/os_spec.rb:150:in `block (2 levels) in <top (required)>'

Finished in 0.03682 seconds
36 examples, 2 failures
```
- [#67](https://github.com/rdp/os/issues/67) - Test suite hasn't been upgraded to RSpec 3
```
An error occurred while loading ./spec/os_spec.rb.
Failure/Error: config.expect_with :rspec, :stdlib # enable `should` OR `assert`

ArgumentError:
  :stdlib is not supported
# ./spec/spec_helper.rb:8:in `block in <top (required)>'
# ./spec/spec_helper.rb:7:in `<top (required)>'
# ./spec/os_spec.rb:1:in `require'
# ./spec/os_spec.rb:1:in `<top (required)>'
```

# Path Forward

Given the state of this library overall I think the best route forward would be to create a new gem with the same API and funtionality, but with a new name and namespace, so that unmaintained libraries that rely on `os` continue to work without introducing a "chained upgrade hell".

To that end, I have [forked this library](https://github.com/pboling/moss), renamed the fork, and will soon release a new gem called `moss` (Mossy Operating System Stuff) with a top-level namespace module of `Moss`, which provides the same API as this gem.  It will be based on the modern `bundler gem` template, use github actions, integrate the stability fixes from [#48](https://github.com/rdp/os/pull/48), and have [code coverage reporting built in](https://dev.to/pboling/ippccr-in-pursuit-of-perfect-code-coverage-reporting-3a2i) to pull requests, etc.

Because it will be a new gem and a new namespace, the two gems can be used side by side with no problems!  No one is forced to upgrade anything, and the ecosystem remains intact!

Prior to making the fork forky though (the namespace change) I'll do upgrades that I can PR upstream to this repo, so they both benefit!

I will upstream fixes for:
- [x] [#55](https://github.com/rdp/os/issues/55) fixed by [#59](https://github.com/rdp/os/pull/59)
- [ ] [#56](https://github.com/rdp/os/issues/56)
- [ ] [#57](https://github.com/rdp/os/issues/57)
- [ ] [#58](https://github.com/rdp/os/issues/58)
- [x] [#60](https://github.com/rdp/os/issues/60) fixed by [#59](https://github.com/rdp/os/pull/59)
- [ ] [#61](https://github.com/rdp/os/issues/61)
- [ ] [#62](https://github.com/rdp/os/issues/62)
- [ ] [#63](https://github.com/rdp/os/issues/63)
- [ ] [#64](https://github.com/rdp/os/issues/64)
- [x] [#67](https://github.com/rdp/os/issues/67) fixed by [#68](https://github.com/rdp/os/pull/68)

# Q & A

Question: Why am I doing this if I have never before used this library?

> I am working on upgrading my `rspec-pending_for` [gem](https://github.com/pboling/rspec-pending_for), and need the functionality this library provides, and will probably want to extend the functionality.  Given that the maintainer may not want my extensions, the trouble caused by churn if the issues were to be addressed, and the actual current issues it seemed best to hard fork. - @pboling, here, now

Question: Why `moss`?

> I considered `oss`, but it has a strong association with Open Source Software already.  I considered `os2`, but google searches for os2 in the computer programming context are saturated by IBM's eponymous product.  So aping on the  _stolid_ linux tradition of package names that are self-referencing, I chose `moss`. - @pboling, here, now

Interested to hear what [@rdp](https://github.com/rdp) thinks about all this.

>
> > End Quote

Stay tuned for further posts in this series!

- [Part 2](/posts/rubygems/repair_old_gem_2)

> [Hero image (cropped)](https://unsplash.com/photos/rXi6VEpoSqQ) by [Jon Tyson](https://unsplash.com/@jontyson)
