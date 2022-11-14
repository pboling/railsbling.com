+++
date = "2020-03-18T10:00:00-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "New Release of oauth2: Version 1.4.7"
tags = [ "development", "ruby", "rails", "rubygems", "oauth2", "authentication" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

## oauth2 version 1.4.7 is Released

<!-- oauth2-badges -->
[![Gem Version](http://img.shields.io/gem/v/oauth2.svg)][gem]
[![Total Downloads](https://img.shields.io/gem/dt/oauth2.svg)][gem]
[![Downloads Today](https://img.shields.io/gem/rt/oauth2.svg)][gem]
[![Network](https://img.shields.io/github/forks/oauth-xx/oauth2.svg?style=social)][network]
[![Stars](https://img.shields.io/github/stars/oauth-xx/oauth2.svg?style=social)][stargazers]
[![Build Status](http://img.shields.io/travis/oauth-xx/oauth2.svg)][travis]
[![Test Coverage](https://api.codeclimate.com/v1/badges/688c612528ff90a46955/test_coverage)][codeclimate-coverage]
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
[codeclimate-coverage]: https://codeclimate.com/github/oauth-xx/oauth2/test_coverage
[depfu]: https://depfu.com/github/oauth-xx/oauth2
[source-license]: https://opensource.org/licenses/MIT
[inch-ci]: http://inch-ci.org/github/oauth-xx/oauth2
[code-triage]: https://www.codetriage.com/oauth-xx/oauth2

The oauth2 gem team has been working ([103 Issues Closed, 3 remaining!](https://github.com/oauth-xx/oauth2/milestone/1?closed=1)) on preparing a version 2.0.0 for release.  It will have some minor breaking changes, and some important bug fixes.  It will have code cleanup, and new features.

**But for many people version 1.4.x has been working fine**, and all they need is a new version, warts and all, which fixes some bugs, adds some features, and allows them to upgrade some dependencies, particularly `jwt` and `faraday`.  So I have [prepared a 1.4.7 release](https://github.com/oauth-xx/oauth2/milestone/9?closed=1).

Here is the relevant section of [CHANGELOG.md](https://github.com/oauth-xx/oauth2/blob/1-4-stable/CHANGELOG.md#147---2021-03-18):

## [1.4.7] - 2020-03-19

- [#541](https://github.com/oauth-xx/oauth2/pull/541) - Backport fix to expires_at handling [#533](https://github.com/oauth-xx/oauth2/pull/533) to 1-4-stable branch. (@dobon)

[1.4.7]: https://github.com/oauth-xx/oauth2/compare/v1.4.6...v1.4.7
