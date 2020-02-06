+++
date = "2018-10-13T01:00:00-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "New Release of oauth2: Version 1.4.1"
tags = [ "development", "ruby", "rails", "rubygems", "oauth2" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

## oauth2 version 1.4.1 is Released

[![Gem Version](http://img.shields.io/gem/v/oauth2.svg)][gem]
[![Total Downloads](https://img.shields.io/gem/dt/oauth2.svg)][gem]
[![Downloads Today](https://img.shields.io/gem/rt/oauth2.svg)][gem]
[![Network](https://img.shields.io/github/forks/oauth-xx/oauth2.svg?style=social)][network]
[![Stars](https://img.shields.io/github/stars/oauth-xx/oauth2.svg?style=social)][stargazers]
[![Build Status](http://img.shields.io/travis/oauth-xx/oauth2.svg)][travis]
[![Coverage Status](http://img.shields.io/coveralls/oauth-xx/oauth2.svg)][coveralls]
[![Maintainability](https://api.codeclimate.com/v1/badges/688c612528ff90a46955/maintainability)][codeclimate-maintainability]
[![Depfu](https://badges.depfu.com/badges/6d34dc1ba682bbdf9ae2a97848241743/count.svg)][depfu]
[![Open Source Helpers](https://www.codetriage.com/oauth-xx/oauth2/badges/users.svg)][code-triage]
[![Chat](https://img.shields.io/gitter/room/oauth-xx/oauth2.svg)](https://gitter.im/oauth-xx/oauth2)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)][source-license]
[![Documentation](http://inch-ci.org/github/oauth-xx/oauth2.png)][inch-ci]

[gem]: https://rubygems.org/gems/oauth2
[network]: https://github.com/oauth-xx/oauth2/network
[stargazers]: https://github.com/oauth-xx/oauth2/stargazers
[travis]: http://travis-ci.org/oauth-xx/oauth2
[coveralls]: https://coveralls.io/r/oauth-xx/oauth2
[codeclimate-maintainability]: https://codeclimate.com/github/oauth-xx/oauth2/maintainability
[depfu]: https://depfu.com/github/oauth-xx/oauth2
[source-license]: https://opensource.org/licenses/MIT
[inch-ci]: http://inch-ci.org/github/oauth-xx/oauth2
[code-triage]: https://www.codetriage.com/oauth-xx/oauth2

The oauth2 gem team has been working hard ([72 Issues Closed, 6 remaining!](https://github.com/oauth-xx/oauth2/milestone/1?closed=1)) on preparing a version 2.0.0 for release.  It will have some minor breaking changes, and some important bug fixes.  It will have code cleanup, and new features.

**But for many people version 1.4.0 has been working fine**, and all they need is a new version, warts and all, which allows them to upgrade some locked dependencies, particularly `jwt` and `faraday`.  So I have [prepared a 1.4.1 release](https://github.com/oauth-xx/oauth2/milestone/3?closed=1).

Here is the relevant section of [CHANGELOG.md](https://github.com/oauth-xx/oauth2/blob/1-4-stable/CHANGELOG.md):

## [1.4.1] - 2018-10-13

- [#417](https://github.com/oauth-xx/oauth2/pull/417) - update jwt dependency (@thewoolleyman)
- [#418](https://github.com/oauth-xx/oauth2/pull/418) - remove rubocop dependency (temporary, added back in [#423](https://github.com/oauth-xx/oauth2/pull/423)) (@pboling)
- [#419](https://github.com/oauth-xx/oauth2/pull/419) - update faraday dependency (@pboling)
- [#420](https://github.com/oauth-xx/oauth2/pull/420) - update [oauth2.gemspec](https://github.com/oauth-xx/oauth2/blob/1-4-stable/oauth2.gemspec) (@pboling)
- [#421](https://github.com/oauth-xx/oauth2/pull/421) - fix [CHANGELOG.md](https://github.com/oauth-xx/oauth2/blob/1-4-stable/CHANGELOG.md) for previous releases (@pboling)
- [#422](https://github.com/oauth-xx/oauth2/pull/422) - update [LICENSE](https://github.com/oauth-xx/oauth2/blob/1-4-stable/LICENSE) and [README.md](https://github.com/oauth-xx/oauth2/blob/1-4-stable/README.md) (@pboling)
- [#423](https://github.com/oauth-xx/oauth2/pull/423) - update [builds](https://travis-ci.org/oauth-xx/oauth2/builds), [Rakefile](https://github.com/oauth-xx/oauth2/blob/1-4-stable/Rakefile) (@pboling)
  - officially document supported Rubies
    * Ruby 1.9.3
    * Ruby 2.0.0
    * Ruby 2.1
    * Ruby 2.2
    * [JRuby 1.7][jruby-1.7] (targets MRI v1.9)
    * [JRuby 9.0][jruby-9.0] (targets MRI v2.0)
    * Ruby 2.3
    * Ruby 2.4
    * Ruby 2.5
    * [JRuby 9.1][jruby-9.1] (targets MRI v2.3)
    * [JRuby 9.2][jruby-9.2] (targets MRI v2.5)

[jruby-1.7]: https://www.jruby.org/2017/05/11/jruby-1-7-27.html
[jruby-9.0]: https://www.jruby.org/2016/01/26/jruby-9-0-5-0.html
[jruby-9.1]: https://www.jruby.org/2017/05/16/jruby-9-1-9-0.html
[jruby-9.2]: https://www.jruby.org/2018/05/24/jruby-9-2-0-0.html
[1.4.1]: https://github.com/oauth-xx/oauth2/compare/v1.4.0...v1.4.1
