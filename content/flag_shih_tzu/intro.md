+++
date = "2013-08-06T12:30:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "Maintaining flag_shih_tzu"
tags = [ "development", "ruby", "rails", "rubygems", "flag_shih_tzu", "database", "active_record" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

## Bit Fields for Active Record

[![Total Downloads](https://img.shields.io/gem/rt/flag_shih_tzu.svg)](https://github.com/pboling/flag_shih_tzu)
[![Downloads Today](https://img.shields.io/gem/rd/flag_shih_tzu.svg)](https://github.com/pboling/flag_shih_tzu)
[![Code Quality](https://img.shields.io/codeclimate/github/pboling/flag_shih_tzu.svg)](https://codeclimate.com/github/pboling/flag_shih_tzu)
[![Network](https://img.shields.io/github/forks/pboling/flag_shih_tzu.svg?style=social)](https://github.com/pboling/flag_shih_tzu/network)
[![Stars](https://img.shields.io/github/stars/pboling/flag_shih_tzu.svg?style=social)](https://github.com/pboling/flag_shih_tzu/stargazers)
[![Version](https://img.shields.io/gem/v/flag_shih_tzu.svg)](https://rubygems.org/gems/flag_shih_tzu)
[![Build](https://img.shields.io/travis/pboling/flag_shih_tzu.svg)](https://travis-ci.org/pboling/flag_shih_tzu)
[![Documentation](http://inch-ci.org/github/pboling/flag_shih_tzu.svg)](http://inch-ci.org/github/pboling/flag_shih_tzu)
[![Depfu](https://badges.depfu.com/badges/f011a69cf2426f91483aaade580823ac/count.svg)](https://depfu.com/github/pboling/flag_shih_tzu?project_id=2685)
[![Chat](https://img.shields.io/gitter/room/pboling/flag_shih_tzu.svg)](https://img.shields.io/gitter/room/pboling/flag_shih_tzu.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

### What is a bit field?

[https://en.wikipedia.org/wiki/Bit_field](https://en.wikipedia.org/wiki/Bit_field)

### What is a bitwise operation?

[https://en.wikipedia.org/wiki/Bitwise_operation](https://en.wikipedia.org/wiki/Bitwise_operation)

`flag_shih_tzu` supports both `:bit_operator` and `:in_list` query modes, but only `:in_list` can will utilize a database index.

### What does it look like?

```ruby
class Lead < ActiveRecord::Base
  include FlagShihTzu
  has_flags 1 => :warm_up_email_sent,
            2 => :follow_up_call_made,
            3 => :final_email_sent,
            4 => :appointment_scheduled,
            5 => :not_interested,
            # You can specify use any integer column to use for flags!
            column: 'actions_taken',
            flag_query_mode: :in_list # or :bit_operator
end

# Flag values always default to false
lead = Lead.new(warm_up_email_sent: true)
# Provides accessors with the same API as a regular boolean column:
lead.warm_up_email_sent # => true
lead.actions_taken # => 1
lead.follow_up_call_made? # => false
lead.follow_up_call_made = true
lead.follow_up_call_made? # => true
lead.actions_taken # => 3
```
