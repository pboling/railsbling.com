+++
date = "2015-09-03T09:26:22-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "Fix The Nokogiri Warning"
tags = [ "development", "ruby", "rubygems", "nokogiri", "bundler" ]
categories = [ "development", "howto", "ruby" ]
series = [ "Rails Project Setup" ]

+++

One of the most consistent warnings that has been with me through the years has been that Nokogiri was built against a version of libXML that is different than the version that is dynamically loaded.

```
WARNING: Nokogiri was built against LibXML version 2.6.30, but has dynamically loaded 2.9.0
```

I had most recently, out of frustration, and due to sundry circumstances, resorted to the `--use-system-libraries` flag in my project's bundler config just to get shit done.

Then I started getting seg faults in a bit of code, and in eliminating this as the cause, I have decided to figure out the real fix.

Googling around I found a bunch of dead links, and this [old gist](https://gist.github.com/devpuppy/1349681) that had some helpful information, but which was also no longer correct.

I was able to fix mine.  Here's how.

First uninstall the old junk.

    gem uninstall nokogiri libxml-ruby
    brew uninstall --force libxml2
    brew uninstall --force libxslt

Then update homebrew.

    brew update

Then install the new packages.

    brew install libxml2 --with-xml2-config
    brew install libxslt

`libxml2` installed version `2.9.2`, keg only.

`libxslt` installed version `1.1.28_1`, keg only, and has a nice help text on install.

```
To allow the nokogiri gem to link against this libxslt run:
  gem install nokogiri -- --with-xslt-dir=/usr/local/opt/libxslt
```

Config bundler

```
bundle config build.nokogiri -- --with-xml2-dir=/usr --with-xslt-dir=/usr/local/opt/libxslt --with-iconv-dir=/opt/local
```

which warns that you are replacing the existing config, if any:

```
You are replacing the current global value of build.nokogiri, which is currently "--use-system-libraries"
```

And then install `nokogiri` via bundler, which will use the config:

```
bundle install
```

Now when I start up rails I no longer see the warning!

```
∴ bundle exec rails c
[config/initializers/logging.rb] LOG_LEVEL set to 0
Loading development environment (Rails 3.2.22)

Frame number: 0/3
[1] pry(main)> exit
```
