+++
date = "2018-01-04T14:41:16-07:00"
draft = true
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "activerecord-transactionable"
tags = [ "Development", "Ruby", "rails", "RubyGems", "activerecord-transactionable", "Database" ]
categories = [ "Development", "tools", "Ruby" ]
series = [ "Toolchain" ]
type = "docs"

+++

## Properly Implement ActiveRecord Transactions

[![Total Downloads](https://img.shields.io/gem/rt/activerecord-transactionable.svg)](https://github.com/pboling/activerecord-transactionable)
[![Downloads Today](https://img.shields.io/gem/rd/activerecord-transactionable.svg)](https://github.com/pboling/activerecord-transactionable)
[![Code Quality](https://img.shields.io/codeclimate/github/pboling/activerecord-transactionable.svg)](https://codeclimate.com/github/pboling/activerecord-transactionable)
[![Network](https://img.shields.io/github/forks/pboling/activerecord-transactionable.svg?style=social)](https://github.com/pboling/activerecord-transactionable/network)
[![Stars](https://img.shields.io/github/stars/pboling/activerecord-transactionable.svg?style=social)](https://github.com/pboling/activerecord-transactionable/stargazers)
[![Version](https://img.shields.io/gem/v/activerecord-transactionable.svg)](https://rubygems.org/gems/activerecord-transactionable)
[![Build](https://img.shields.io/travis/pboling/activerecord-transactionable.svg)](https://travis-ci.org/pboling/activerecord-transactionable)
[![Documentation](http://inch-ci.org/github/pboling/activerecord-transactionable.svg)](http://inch-ci.org/github/pboling/activerecord-transactionable)
[![Depfu](https://badges.depfu.com/badges/96a4d507f1a61a9368655f60fa3cb70f/count.svg)](https://depfu.com/github/pboling/activerecord-transactionable?project=Bundler)
[![Chat](https://img.shields.io/gitter/room/pboling/activerecord-transactionable.svg)](https://img.shields.io/gitter/room/pboling/activerecord-transactionable.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

Provides a method, `transaction_wrapper` at the class and instance levels that can be used instead of `ActiveRecord#transaction`.  Enables you to do transactions properly, with custom rescues and retry, including with or without locking.
