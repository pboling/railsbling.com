+++
date = "2018-01-04T14:41:16-07:00"
draft = true
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "Introducing anonymous_active_record"
tags = [ "development", "ruby", "rails", "rubygems", "anonymous_active_record", "database" ]
categories = [ "development", "tools", "Ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

## ActiveRecord Without a Database?

[![Total Downloads](https://img.shields.io/gem/rt/anonymous_active_record.svg)](https://github.com/pboling/anonymous_active_record)
[![Downloads Today](https://img.shields.io/gem/rd/anonymous_active_record.svg)](https://github.com/pboling/anonymous_active_record)
[![Code Quality](https://img.shields.io/codeclimate/github/pboling/anonymous_active_record.svg)](https://codeclimate.com/github/pboling/anonymous_active_record)
[![Network](https://img.shields.io/github/forks/pboling/anonymous_active_record.svg?style=social)](https://github.com/pboling/anonymous_active_record/network)
[![Stars](https://img.shields.io/github/stars/pboling/anonymous_active_record.svg?style=social)](https://github.com/pboling/anonymous_active_record/stargazers)
[![Version](https://img.shields.io/gem/v/anonymous_active_record.svg)](https://rubygems.org/gems/anonymous_active_record)
[![Build](https://img.shields.io/travis/pboling/anonymous_active_record.svg)](https://travis-ci.org/pboling/anonymous_active_record)
[![Documentation](http://inch-ci.org/github/pboling/anonymous_active_record.svg)](http://inch-ci.org/github/pboling/anonymous_active_record)
[![Depfu](https://badges.depfu.com/badges/96a4d507f1a61a9368655f60fa3cb70f/count.svg)](https://depfu.com/github/pboling/anonymous_active_record?project=Bundler)
[![Chat](https://img.shields.io/gitter/room/pboling/anonymous_active_record.svg)](https://img.shields.io/gitter/room/pboling/anonymous_active_record.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)


Replacement for broken `Class.new(ActiveRecord::Base)`.

Very useful in testing Rails apps, and even more so for testing gems without having to specify full blown models.

An exceptionally hacky alternative that could also be used for real runtime code, see my other gem [activerecord-tablefree](https://rubygems.org/gems/activerecord-tablefree)!
