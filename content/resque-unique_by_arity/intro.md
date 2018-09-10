+++
date = "2017-04-29T12:30:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "resque-unique_by_arity"
tags = [ "Development", "Ruby", "rails", "RubyGems", "resque-unique_by_arity" ]
categories = [ "Development", "tools", "Ruby" ]
series = [ "Toolchain" ]
type = "docs"

+++

## Magic hacks which allow integration of job multiple Resque plugins providing different types of job uniqueness

Because some jobs have parameters that you do *not* want to consider for determination of uniqueness.

`resque_solo` and `resque-unique_at_runtime` (a `resque-lonely_job` rewrite) will now work together!  Without this gem they are fundamentally incompatible. 

[![Total Downloads](https://img.shields.io/gem/rt/resque-unique_by_arity.svg)](https://github.com/pboling/resque-unique_by_arity)
[![Downloads Today](https://img.shields.io/gem/rd/resque-unique_by_arity.svg)](https://github.com/pboling/resque-unique_by_arity)
[![Build Status](https://travis-ci.org/pboling/resque-unique_by_arity.svg?branch=master)](https://travis-ci.org/pboling/resque-unique_by_arity)
[![Test Coverage](https://api.codeclimate.com/v1/badges/7520df3968eb146c8894/test_coverage)](https://codeclimate.com/github/pboling/resque-unique_by_arity/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/7520df3968eb146c8894/maintainability)](https://codeclimate.com/github/pboling/resque-unique_by_arity/maintainability)
[![Depfu](https://badges.depfu.com/badges/25c6e1e4c671926e9adea898f2df9a47/count.svg)](https://depfu.com/github/pboling/resque-unique_by_arity?project_id=2729)
[![Open Source Helpers](https://www.codetriage.com/pboling/resque-unique_by_arity/badges/users.svg)](https://www.codetriage.com/pboling/resque-unique_by_arity)
[![Network](https://img.shields.io/github/forks/pboling/resque-unique_by_arity.svg?style=social)](https://github.com/pboling/resque-unique_by_arity/network)
[![Stars](https://img.shields.io/github/stars/pboling/resque-unique_by_arity.svg?style=social)](https://github.com/pboling/resque-unique_by_arity/stargazers)
[![Version](https://img.shields.io/gem/v/resque-unique_by_arity.svg)](https://rubygems.org/gems/resque-unique_by_arity)
[![Documentation](http://inch-ci.org/github/pboling/resque-unique_by_arity.svg)](http://inch-ci.org/github/pboling/resque-unique_by_arity)
[![Chat](https://img.shields.io/gitter/room/pboling/resque-unique_by_arity.svg)](https://gitter.im/pboling/resque-unique_by_arity)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

I'll put something here soon.
