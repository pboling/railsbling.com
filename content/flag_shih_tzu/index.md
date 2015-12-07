+++
date = "2015-12-06T23:30:16-07:00"
draft = false
title = "flag_shih_tzu"
tags = [ "Development", "Ruby", "rails", "RubyGems", "flag_shih_tzu" ]
categories = [ "Development", "tools", "Ruby" ]
series = [ "Toolchain" ]

+++

## Bit Fields for Active Record

[![Total Downloads](https://img.shields.io/gem/rt/flag_shih_tzu.svg)](https://github.com/pboling/flag_shih_tzu)
[![Downloads Today](https://img.shields.io/gem/rd/flag_shih_tzu.svg)](https://github.com/pboling/flag_shih_tzu)
[![Code Quality](https://img.shields.io/codeclimate/github/pboling/flag_shih_tzu.svg)](https://codeclimate.com/github/pboling/flag_shih_tzu)
[![Network](https://img.shields.io/github/forks/pboling/flag_shih_tzu.svg?style=social)](https://github.com/pboling/flag_shih_tzu/network)
[![Stars](https://img.shields.io/github/stars/pboling/flag_shih_tzu.svg?style=social)](https://github.com/pboling/flag_shih_tzu/stargazers)
[![Version](https://img.shields.io/gem/v/flag_shih_tzu.svg)](https://rubygems.org/gems/flag_shih_tzu)
[![Build](https://img.shields.io/travis/pboling/flag_shih_tzu.svg)](https://travis-ci.org/pboling/flag_shih_tzu)
[![Documentation](http://inch-ci.org/github/pboling/flag_shih_tzu.png)](http://inch-ci.org/github/pboling/flag_shih_tzu)
[![Dependency Status](https://gemnasium.com/pboling/flag_shih_tzu.png)](https://gemnasium.com/pboling/flag_shih_tzu)

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
