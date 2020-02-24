+++
date = "2020-02-24T22:43:30-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "Upgrade to Catalina with Homebrew, Ruby, & Java"
tags = [ "development", "ruby", "rails", "environment", "homebrew" ]
categories = [ "development", "howto", "ruby" ]
series = [ "Rails Project Setup" ]

+++

I upgraded to Catalina, with Homebrew & Ruby, and this is how I did it *flawlessly*.

## Prepare

If you don't already have homebrew installed, do that first.
Install all Software Updates available in the Apple Menu, up to and including Catalina.

## Hardware

Haven't had any hardware issues yet.

## Software

In order...

### Xcode

The upgrade will erase your previous XCode install.

(*Optional*) (re)Install XCode from the App Store first.  The XCode Command Line Tools will actually install fine even without XCode.

After Xcode is finished installing, open [iTerm](https://www.iterm2.com/downloads.html), which I use as a Terminal.app replacement, or Terminal.app if you are so inclined.

```
∴ xcode-select --install
xcode-select: note: install requested for command line developer tools
```

A dialog opened, I chose "Install", which finished in several minutes.

### Java

Next, run `java`, which prompts with a dialog that has a button "More Info" which takes you to [a website](https://www.oracle.com/java/technologies/javase-jdk13-downloads.html) where you can accept the license and download the Java `.dmg` file.  You need the JDK, not the JRE, if you intend to run java command-line based tools.

```
Unable to find any JVMs matching version "1.7".
No Java runtime present, try --request to install.
∴ java
No Java runtime present, requesting install.
```

Once downloaded, open the `.dmg` (for me it was `jdk-13.0.2_osx-x64_bin`) and install, then restart iTerm.

Add the following to your shell (e.g. `.bash_profile`):
```shell script
export JAVA_HOME=`/usr/libexec/java_home -v 13`
```

Now your Java will be available and version will be correct.
```shell script
java -version
```

Output
```
java version "13.0.2" 2020-01-14
Java(TM) SE Runtime Environment (build 13.0.2+8)
Java HotSpot(TM) 64-Bit Server VM (build 13.0.2+8, mixed mode, sharing)
```

Apps like RubyMine should work now, well, at least launch.

### Homebrew

Update Homebrew.  NOTE: If the update fails you may need to do cleanup first, see below.

```shell script
brew update
```

Run a bit of cleanup.

```shell script
brew doctor
brew prune
```

### GPG

Rather than use the Homebrew GPG (`brew install gpg`) I have switched to using the [GPG Suite](https://gpgtools.org/), which provides a DMG based install.

### rbenv

My pre-existing rbenv installation was working fine for most rubies, though some had to be reinstalled from scratch. TBH though, it is a great idea to reinstall them all from scratch, as some issues, like OpenSSL issues, may only become apparent later on.

```shell script
rbenv uninstall 2.5.1
rbenv install 2.5.7
```  
  
Additionally, I ran into some issues with a dependency on `libxml2`.

```shell script
brew upgrade cmake
brew install libxml2
echo 'export PATH="/usr/local/opt/libxml2/bin:$PATH"' >> ~/.shared/paths # NOTE: change the end to ~/.bash_profile or somewhere appropriate
bundle config build.libxml-ruby --with-xml2-config=/usr/local/opt/libxml2/bin/xml2-config --with-xml2-dir=/usr/local/opt/libxml2 --with-xml2-lib=/usr/local/opt/libxml2/lib --with-xml2-include=/usr/local/opt/libxml2/include
bundle install
```

### Postgres

I also took the opportunity to upgrade to the [latest Postgres.app](http://postgresapp.com/).  Alternatively you can install postgres with `brew install postgres`.  I choose Postgres.app begause it is supported directly by Heroku, and I like to think there is a parity win there somewhere.

### MySQL

Mostly I followed [this gist](https://gist.github.com/operatino/392614486ce4421063b9dece4dfe6c21), and [this gist](https://gist.github.com/fernandoaleman/ee3ac6957c2ba4f7d7d33a251d58b191#gistcomment-2735728).

```shell script
brew tap homebrew/services
brew uninstall mysql@5.7
brew install mysql@5.7
brew services list
brew services start mysql@5.7
brew link mysql@5.7 --force
mysql -V
bundle config build.mysql2 --with-ldflags=-L/usr/local/opt/openssl/lib --with-cppflags=-I/usr/local/opt/openssl/include
bundle install
```

### End Result

Glorious.
