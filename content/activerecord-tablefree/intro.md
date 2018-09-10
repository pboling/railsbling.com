+++
date = "2017-11-14T14:41:16-07:00"
draft = true
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "activerecord-tablefree"
tags = [ "Development", "Ruby", "rails", "RubyGems", "activerecord-tablefree", "Database" ]
categories = [ "Development", "tools", "Ruby" ]
series = [ "Toolchain" ]
type = "docs"

+++

## ActiveRecord Without a Database?

[![Total Downloads](https://img.shields.io/gem/rt/activerecord-tablefree.svg)](https://github.com/pboling/activerecord-tablefree)
[![Downloads Today](https://img.shields.io/gem/rd/activerecord-tablefree.svg)](https://github.com/pboling/activerecord-tablefree)
[![Build](https://img.shields.io/travis/pboling/activerecord-tablefree.svg)](https://travis-ci.org/pboling/activerecord-tablefree)
[![Test Coverage](https://api.codeclimate.com/v1/badges/9354ad73daf12d480e81/test_coverage)](https://codeclimate.com/github/pboling/activerecord-tablefree/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/9354ad73daf12d480e81/maintainability)](https://codeclimate.com/github/pboling/activerecord-tablefree/maintainability)
[![Network](https://img.shields.io/github/forks/pboling/activerecord-tablefree.svg?style=social)](https://github.com/pboling/activerecord-tablefree/network)
[![Stars](https://img.shields.io/github/stars/pboling/activerecord-tablefree.svg?style=social)](https://github.com/pboling/activerecord-tablefree/stargazers)
[![Version](https://img.shields.io/gem/v/activerecord-tablefree.svg)](https://rubygems.org/gems/activerecord-tablefree)
[![Open Source Helpers](https://www.codetriage.com/pboling/activerecord-tablefree/badges/users.svg)](https://www.codetriage.com/pboling/activerecord-tablefree) 
[![Depfu](https://badges.depfu.com/badges/96a4d507f1a61a9368655f60fa3cb70f/count.svg)](https://depfu.com/github/pboling/activerecord-tablefree?project=Bundler)
[![Chat](https://img.shields.io/gitter/room/pboling/activerecord-tablefree.svg)](https://img.shields.io/gitter/room/pboling/activerecord-tablefree.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

ActiveRecord Tablefree Models provides a simple mixin for creating models that are not bound to the database. This approach is useful for taking advantage of the features of ActiveRecord such as validation, relationships, nested_attributes, etc.

This can also be very useful in testing where a mock-like object will suffice.

This gem is exceptionally hacky.  For an alternative solution, primarily aimed at testing, that is less hacky, see my other gem [anonymous_active_record](https://rubygems.org/gems/anonymous_active_record)!