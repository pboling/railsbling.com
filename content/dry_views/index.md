+++
date = "2015-12-06T23:30:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "dry_views"
tags = [ "Development", "Ruby", "rails", "RubyGems", "dry_views" ]
categories = [ "Development", "tools", "Ruby" ]
series = [ "Toolchain" ]

+++

## Enhancer of Rails' content_for system.  Allows defaults, and no_content_for overrides in partials.  For Rails 3, 4.

[![Total Downloads](https://img.shields.io/gem/rt/dry_views.svg)](https://github.com/pboling/dry_views)
[![Downloads Today](https://img.shields.io/gem/rd/dry_views.svg)](https://github.com/pboling/dry_views)
[![Code Quality](https://img.shields.io/codeclimate/github/pboling/dry_views.svg)](https://codeclimate.com/github/pboling/dry_views)
[![Network](https://img.shields.io/github/forks/pboling/dry_views.svg?style=social)](https://github.com/pboling/dry_views/network)
[![Stars](https://img.shields.io/github/stars/pboling/dry_views.svg?style=social)](https://github.com/pboling/dry_views/stargazers)
[![Version](https://img.shields.io/gem/v/dry_views.svg)](https://rubygems.org/gems/dry_views)
[![Build](https://img.shields.io/travis/pboling/dry_views.svg)](https://travis-ci.org/pboling/dry_views)
[![Documentation](http://inch-ci.org/github/pboling/dry_views.png)](http://inch-ci.org/github/pboling/dry_views)
[![Dependency Status](https://gemnasium.com/pboling/dry_views.png)](https://gemnasium.com/pboling/dry_views)

## Why?

* Keep the views dry with content_for_with_default and friends!
* Complete flexibility in defining defaults and overrides.
* Remove most or all logic from views.
* Allow for no content to override a default.

DryViews provides extensions to ActionView::Helpers::CaptureHelper, which is part of ActionPack:
* content_for_with_default
* no_content_for
* content_for (enhanced to play nice with the above methods)

The rails rendering chain is sort of inside out so the template rendering happens first, and this is what makes it possible to override everything! The template will ALWAYS override the layout, and a partial will always override a partial layout.

Here are some guidelines for using the code below with HAML (see the [wiki for ERB examples](https://github.com/pboling/dry_views/wiki/ERB-Usage-Example)):

    - no_content_for :key
    # Use a dash (-) not equals (=)
    # Will prevent a later content_for from rendering.  This allows template overrides of layouts.

    = content_for_with_default :key
    # Use an equal (=) not a dash (-)
    # You provide it with the default HAML via a block *or* a set of params that are the same as you would pass to a standard "render" call (i.e. :partial => 'foo', :locals => {:bar => 'bar'}).

    = content_for :key
    # Use an equal (=) not a dash (-)
    # You provide it with a block, i.e. {render :partial => 'foo'}, and it will override content_for_with_default.  It has the same precedence as no_content_for, so whichever is rendered first wins, so if a layout has either no_content_for or content_for (with or without default) the template can now override it.

## Installation

Add this line to your application's Gemfile:

    gem 'dry_views'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dry_views

## Usage

Example #1:
in a layout

    - no_content_for :breakfast                 # ARROWED!

in a template

    = content_for :breakfast do                 # WINNER!
      %h1 Dub Step

will have Dub Step

Example #2:
in a layout

    = content_for :breakfast do                 # ARROWED!
      %h1 Dub Step

in a template

    - no_content_for :breakfast                 # WINNER!

will have NOTHING

Example #3:

in a layout

    = content_for :breakfast do                 # WINNER!
      %h1 Dub Step

in a template

    = content_for :breakfast do                 # WINNER!
      %h1 Metal

will have Dub Step and Metal (Concatenation!)

Example #4:
in a layout

    = content_for_with_default :breakfast do    # ARROWED!
      %h1 Dub Step

in a template

    = content_for :breakfast do                 # WINNER!
      %h1 Metal

will have Metal only (No Dub Step!)

Example #5:

in a layout

    = content_for_with_default :breakfast do    # ARROWED!
    %h1 Dub Step

in a template

    - no_content_for :breakfast                 # WINNER!

will have NOTHING

Example #6:
in a layout

    = content_for_with_default :breakfast do    # ARROWED!
      %h1 Dub Step

in a template

    = render :partial => 'hip_hop', :layout => 'sample'
    = no_content_for :breakfast do              # ARROWED!

in the 'sample' partial layout

    = no_content_for :breakfast do              # ARROWED!

in the 'hip_hop' partial

    = content_for :breakfast do                 # WINNER!
      %h1 Hip Hop

will have Hip Hop only (No Dub Step!)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

