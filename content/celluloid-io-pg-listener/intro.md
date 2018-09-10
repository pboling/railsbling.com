+++
date = "2015-10-06T00:30:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "celluloid-io-pg-listener"
tags = [ "Development", "Ruby", "rails", "RubyGems", "celluloid-io-pg-listener" ]
categories = [ "Development", "tools", "Ruby" ]
series = [ "Toolchain" ]
type = "docs"

+++

## LISTEN for Postgresql NOTIFY messages;

### Asynchronously process payloads

[![Total Downloads](https://img.shields.io/gem/rt/celluloid-io-pg-listener.svg)](https://github.com/pboling/celluloid-io-pg-listener)
[![Downloads Today](https://img.shields.io/gem/rd/celluloid-io-pg-listener.svg)](https://github.com/pboling/celluloid-io-pg-listener)
[![Code Quality](https://img.shields.io/codeclimate/github/pboling/celluloid-io-pg-listener.svg)](https://codeclimate.com/github/pboling/celluloid-io-pg-listener)
[![Network](https://img.shields.io/github/forks/pboling/celluloid-io-pg-listener.svg?style=social)](https://github.com/pboling/celluloid-io-pg-listener/network)
[![Stars](https://img.shields.io/github/stars/pboling/celluloid-io-pg-listener.svg?style=social)](https://github.com/pboling/celluloid-io-pg-listener/stargazers)
[![Version](https://img.shields.io/gem/v/celluloid-io-pg-listener.svg)](https://rubygems.org/gems/celluloid-io-pg-listener)
[![Build](https://img.shields.io/travis/pboling/celluloid-io-pg-listener.svg)](https://travis-ci.org/pboling/celluloid-io-pg-listener)
[![Documentation](http://inch-ci.org/github/pboling/celluloid-io-pg-listener.svg)](http://inch-ci.org/github/pboling/celluloid-io-pg-listener)
[![Dependency Status](https://gemnasium.com/pboling/celluloid-io-pg-listener.svg)](https://gemnasium.com/pboling/celluloid-io-pg-listener)
[![Chat](https://img.shields.io/gitter/room/pboling/celluloid-io-pg-listener.svg)](https://gitter.im/pboling/celluloid-io-pg-listener)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

`celluloid-io-pg-listener` (on [github](https://github.com/pboling/celluloid-io-pg-listener))

# Why?

At [Trumaker & Co](http://www.trumaker.com) we had a distributed data problem.
Two data stores that needed to be kept synchronized, in real time, with inserts and updates allowed on both sides.
There wasn't a good solution available for that, so I did a lot of research and built `celluloid-io-pg-listener` to solve the problem.

# How?

The data stores are both PostgreSQL databases living in different `namespaces` (i.e. `schemas` in PostgreSQL-speak).  A recently improved feature of PostgreSQL is the built-in pub/sub type messaging channel.  It can pass payloads, and as of version `9.4`, has a built-in function (`json_build_object`) to serialize data as `JSON`.

With some triggers and functions on both sides connected by the channel payloads would be sent with information about inserts and updates happening on the other side.

# I want to know more!

Read [this little tutorial.](/posts/introducing-celluloid-io-pg-listener/)
