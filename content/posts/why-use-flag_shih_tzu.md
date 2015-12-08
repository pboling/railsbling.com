+++
date = "2015-12-07T00:21:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "Why Should You Use flag_shih_tzu"
tags = [ "Development", "Ruby", "rails", "RubyGems", "flag_shih_tzu" ]
categories = [ "Development", "tools", "Ruby" ]
series = [ "Toolchain" ]

+++

### What is it?

See [the what is it post.](/flag_shih_tzu)

### Why should you use it?

* No migrations needed for new boolean attributes
* Avoids ALTER TABLE when adding a new boolean field to a model, which can be important for very large tables
* Only the one integer column needs to be indexed
* The index is actually meaningful, unlike a boolean column index
* Bitwise operations are fast, indexes are even faster, and you can use either one
* Adds scopes to easily access collections of records with specific fields
  * Chained scopes to combine sql for different bit fields for maximum performance
* Provides condition builder methods for each bit field so you can construct your own custom SQL with the correct bit field values for the list.
  * Table alias option to allow it to work with tables aliased in a query (e.g. custom joins)
* Has a `set_flag_sql` method useful when doing mass updates without initializing object for each row.
* Has a `update_flag!` method useful when you want to set a flag, but avoid validations and callbacks on the record.

### Why is it better than the alternative?

The competition is Michael Grosser's [bitfields](https://github.com/grosser/bitfields), and as always, it depends on your needs. Grosser's library is less than half the size of `flag_shih_tzu`, and has far fewer features, and a much smaller compatibility matrix.  Some of the differences are laid out below.

For some things however, you only have one option.  If you are still on legacy Ruby or legacy Rails, or using jRuby, then use `flag_shih_tzu`.  If you need multiple flag columns on a single model, use `flag_shih_tzu`.  If you want to use it with form builders, it is slightly easier with `flag_shih_tzu`.

comparison            | flag_shih_tzu | bitfields
--------------------- | ------------- | ---------
Age                   | Mar 2009      | Mar 2010
Legacy MRI Support    | [1.8.7, 1.9.2](https://github.com/pboling/flag_shih_tzu/tree/0.2.X#prerequisites "0.2.X branch") | None
Current MRI Support   | [1.9.3, 2.0, 2.1, 2.2](https://github.com/pboling/flag_shih_tzu/tree/master#compatibility-matrix "Compatability Matrix") | 1.9.3 2.0
Current jRuby Support | [jRuby-1.7, jRuby-9.0](https://github.com/pboling/flag_shih_tzu/tree/master#compatibility-matrix "Compatability Matrix") | None
Legacy Rails Support  | [2.3, 3.0, 3.1, 3.2](https://github.com/pboling/flag_shih_tzu/tree/0.2.X#prerequisites "0.2.X branch") | None
Current Rails Support | [2.3, 3.0, 3.1, 3.2, 4.0, 4.1, 4.2](https://github.com/pboling/flag_shih_tzu/tree/master#compatibility-matrix "Compatability Matrix") | 3.2, 4.0, 4.1, 4.2
Stars                 | [![Stars](https://img.shields.io/github/stars/pboling/flag_shih_tzu.svg?style=social)](https://github.com/pboling/flag_shih_tzu/stargazers) | [![Stars](https://img.shields.io/github/stars/grosser/bitfields.svg?style=social)](https://github.com/grosser/bitfields/stargazers)
Forks                 | [![Network](https://img.shields.io/github/forks/pboling/flag_shih_tzu.svg?style=social)](https://github.com/pboling/flag_shih_tzu/network) | [![Network](https://img.shields.io/github/forks/grosser/bitfields.svg?style=social)](https://github.com/grosser/bitfields/network)
Downloads (All-time)  | [![Total Downloads](https://img.shields.io/gem/rt/flag_shih_tzu.svg)](https://github.com/pboling/flag_shih_tzu) | [![Total Downloads](https://img.shields.io/gem/rt/bitfields.svg)](https://github.com/grosser/bitfields)
Downloads (Today)     | [![Downloads Today](https://img.shields.io/gem/rd/flag_shih_tzu.svg)](https://github.com/pboling/flag_shih_tzu) | [![Downloads Today](https://img.shields.io/gem/rd/bitfields.svg)](https://github.com/grosser/bitfields)
Code Quality          | [![Code Quality](https://img.shields.io/codeclimate/github/pboling/flag_shih_tzu.svg)](https://codeclimate.com/github/pboling/flag_shih_tzu) | [![Code Quality](https://img.shields.io/codeclimate/github/grosser/bitfields.svg)](https://codeclimate.com/github/grosser/bitfields)
Build                 | [![Build](https://img.shields.io/travis/pboling/flag_shih_tzu.svg)](https://travis-ci.org/pboling/flag_shih_tzu) | [![Build](https://img.shields.io/travis/grosser/bitfields.svg)](https://travis-ci.org/grosser/bitfields)
Documentation         | [![Documentation](http://inch-ci.org/github/pboling/flag_shih_tzu.png)](http://inch-ci.org/github/pboling/flag_shih_tzu) | [![Documentation](http://inch-ci.org/github/grosser/bitfields.png)](http://inch-ci.org/github/grosser/bitfields)
Dependency Status     | [![Dependency Status](https://gemnasium.com/pboling/flag_shih_tzu.png)](https://gemnasium.com/pboling/flag_shih_tzu) | [![Dependency Status](https://gemnasium.com/grosser/bitfields.png)](https://gemnasium.com/grosser/bitfields)
Custom Flag Column Name | Yes | Yes
Multiple Flag Columns per Model | [Yes](https://github.com/pboling/flag_shih_tzu#using-a-custom-column-name) | No
Has analog [to `update_column`](http://api.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-update_column) | [Yes](https://github.com/pboling/flag_shih_tzu/tree/master#callbacks-and-validations "update_flag!") | No
Built-in use [with `update_all`](http://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-update_all "ActiveRecord::Relation") | [Yes](https://github.com/pboling/flag_shih_tzu#updating-flag-column-by-raw-sql "set_flag_sql") | [Yes](https://github.com/grosser/bitfields/blob/master/lib/bitfields.rb#L62 "set_bitfield_sql")
Built-in use [with form builders](https://github.com/plataformatec/simple_form#usage "SimpleForm or Rails") | [Yes](https://github.com/pboling/flag_shih_tzu/blob/master/lib/flag_shih_tzu.rb#L544 "as_flag_collection") | No
Built-in Validator    | [Yes](https://github.com/pboling/flag_shih_tzu/blob/master/lib/flag_shih_tzu/validators.rb#L37 "validated_presence_of_flags") | No
Change Tracking `_was` | No | [Yes](https://github.com/grosser/bitfields/blob/master/lib/bitfields.rb#L87)
Change Tracking `_changed?` | [Yes](https://github.com/pboling/flag_shih_tzu/blob/master/lib/flag_shih_tzu.rb#L105) | [Yes](https://github.com/grosser/bitfields/blob/master/lib/bitfields.rb#L88)
Change Tracking `_change` | No | [Yes](https://github.com/grosser/bitfields/blob/master/lib/bitfields.rb#L89)
Scopes Optional       | Yes | Yes
