+++
date = "2015-09-30T22:43:30-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "Upgrade to El Capitan with Homebrew, Ruby, qt5, & Java"
tags = [ "development", "ruby", "rails", "environment", "homebrew", "qt5", "java" ]
categories = [ "development", "howto", "ruby" ]
series = [ "Rails Project Setup" ]

+++

I upgraded to El Capitan, with Homebrew & Ruby, and this is how I did it *flawlessly*.

... and Xcode and Java, etc.

## Prepare

If you don't already have homebrew installed, do that first, so you don't have to deal with [SIP issues](https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/El_Capitan_and_Homebrew.md#if-usrlocal-does-not-exist).
Install all Software Updates available in the Apple Menu, up to and including El Capitan.

## Hardware

After the installs and forced reboots my 27" Thunderbolt display wouldn't display anything.  Unplug, replug didn't help.  One more reboot fixed it.

## Software

In order...

### Xcode

~~The El Capitan install wiped out my Xcode install~~, so I had to search for it in the App Store and reinstall.  I now believe that I deleted Xcode awhile ago and forgot, hence the reinstall.  I did this on a machine that I rarely use.

After Xcode is finished installing, open [iTerm](https://www.iterm2.com/downloads.html), which I use as a Terminal.app replacement, or Terminal.app if you are so inclined.

```
∴ xcode-select --install
xcode-select: note: install requested for command line developer tools
```

A dialog opened, I chose "Install", which finished in about a minute.

### Java

Next, run `java`, which prompts with a dialog that has a button "More Info" which takes you to [a website](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) where you can accept the license and download the Java `.dmg` file.  You need the JDK, not the JRE, if you intend to run java command-line based tools.

```
Unable to find any JVMs matching version "1.7".
No Java runtime present, try --request to install.
∴ java
No Java runtime present, requesting install.
```

Once downloaded, open the `.dmg` (for me it was `jdk-8u60-macosx-x64.dmg`) and install, then restart iTerm.

```
∴ java -version
java version "1.8.0_60"
Java(TM) SE Runtime Environment (build 1.8.0_60-b27)
Java HotSpot(TM) 64-Bit Server VM (build 25.60-b23, mixed mode)
```

Apps like RubyMine should work now, well, at least launch.

### Homebrew

The doctor informed me of several warnings which I took care of as instructed.

```
∴ brew doctor
∴ sudo chown -R $(whoami):admin /usr/local
∴ cd /usr/local/Library && git stash && git clean -d -f
∴ cd ~
∴ brew prune
∴ brew unlink qt5
```

Then I was able to update Homebrew.

```
∴ brew update
```

### qt5

I know the `capybara-webkit` gem will require qt5, and I know qt is one of the primary remaining pain points in [homebrew / El Capitan issues tracker](https://github.com/Homebrew/homebrew/issues?utf8=✓&q=is%3Aissue+is%3Aopen+Capitan), so I decided to get it out of the way first.

```
∴ brew uninstall qt5
∴ brew install qt5
∴ brew linkapps qt5
∴ brew link --force qt5
```

That last line is required to make `qmake` available.  Check with `which qmake`.  Otherwise you will end up with this on the Capybara install later on:

```
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.

    /Users/pboling/.rvm/rubies/ruby-2.1.2/bin/ruby -r ./siteconf20150930-48087-1vw6bye.rb extconf.rb
sh: qmake: command not found
*** extconf.rb failed ***
```

### GPG

Some software is now being signed with GPG, like RVM, for example, so install it.

```
brew install gpg
```

### RVM

My Ruby was working, but I was having trouble with some native gem installations, so I decided to start fresh with a Ruby compiled against all the new homebrew and Xcode libraries.

```
rvm implode
```

Implode actually failed to remove the main `~/.rvm` directory due to permissions issues.  I had to `sudo` remove it.

```
sudo rm -rf /Users/pboling/.rvm
```

Follow the instructions [here for installing RVM](https://rvm.io/rvm/install), I installed the development version, hoping it would have more El Capitan fixes in it:

```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash
```

The main app I currently work on is using Ruby 2.1.2, so I install that first, and then go to the project directory to have the gemset created and to bundle.

**Update 12/21/2015**

I eventually ran into OpenSSL errors due to a certificate chain being outdated.  The error was:

```
SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed:
```

I took a few additional steps to ensure Ruby would be fully operational, including disabling the binary install.

```
∴ rvm osx-ssl-certs update all
# or whichever Ruby you need
∴ rvm reinstall 2.2.3 --disable-binary 
∴ rvm use 2.2.3@myproject 
```

Bundler version 1.9.7 because that's what Heroku is on, and I want to stay in sync, because 1.10* changed things that make the `Gemfile.lock` incompatible with 1.9.7 on the deployed server (for me, with multiple gem sources, private gem server, etc).

```
∴ cd ~/project
# If you use a specific gemset
∴ gem install bundler -v 1.9.7 
∴ bundle install
```

### Postgres

I also took the opportunity to upgrade to the [latest Postgres.app](http://postgresapp.com/).  Alternatively you can install postgres with `brew install postgres`.  I choose Postgres.app begause it is supported directly by Heroku, and I like to think there is a parity win there somewhere.

Glorious.

* [On reddit](https://www.reddit.com/r/ruby/comments/3n26gt/upgrade_to_el_capitan_with_homebrew_ruby/)
* [On Github](https://gist.github.com/pboling/c2bb179e73f8a6ca94e4)
* The reddit version of this post was featured in [RubyWeekly Issue #266, October 1, 2015](http://rubyweekly.com/issues/266)
