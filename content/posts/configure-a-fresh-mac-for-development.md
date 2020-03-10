+++
date = "2020-03-09T23:43:30-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "Configure a Fresh Mac for Development"
tags = [ "development", "ruby", "rails", "environment", "homebrew" ]
categories = [ "development", "howto", "ruby" ]
series = [ "Rails Project Setup" ]

+++

You have a fresh install of Mac OS X Catalina, and all the latest updates installed.  Now you want to do some web development with Ruby on Rails.

I am writing this as a reference for myself, because I go through this process frequently.

# Installations

## Core Setup

• Login to iCloud
• Install Apps from App Store
• Install iTerm2
• Install Franz and Telegram
• Install homebrew (which will also auto-install Apple’s "command line developer tools") and some packages

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install cmake libxml2 git hub asdf pinentry cmake libxml2
• Install GnuPG using the [GPG Suite](https://gpgtools.org/), which provides a DMG based install, then:

    echo "test" | gpg2 --clearsign
    git config --global user.signingkey BA3C3507
    git config --global commit.gpgsign true
    git config --global gpg.program gpg2
• Jetbrains Toolbox: https://www.jetbrains.com/toolbox-app/
• Google backup and sync: https://www.google.com/drive/download/backup-and-sync/
• Dropbox: https://www.dropbox.com/install#downloaded
• Install the [latest Postgres.app](http://postgresapp.com/).

## pboling's (My) Dotfiles

    git clone git://github.com/pboling/dotfiles ~/Documents/src/dotfiles
    ln -s $HOME/Documents/src/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    rake install

NOTE: Quit and reopen iTerm to ensure all shells pickup the new paths, aliases, and other goodies.

## Java

Next, run `java`, which prompts with a dialog that has a button "More Info" which takes you to [a website](https://www.oracle.com/java/technologies/javase-jdk13-downloads.html) where you can accept the license and download the Java `.dmg` file.  You need the JDK, not the JRE, if you intend to run java command-line based tools.

```
Unable to find any JVMs matching version "1.7".
No Java runtime present, try --request to install.
∴ java
No Java runtime present, requesting install.
```

Once downloaded, open the `.dmg` (for me it was `jdk-13.0.2_osx-x64_bin`) and install.

## SSH

Setup a [new key](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent), and [add it to github](https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account).

    chmod 600 ~/.ssh/config
    chown $USER ~/.ssh/config

# ERRORS?

## libxml-ruby

If you get an error installing the `libxml-ruby` gem:


```
bundle config build.libxml-ruby --with-xml2-config=/usr/local/opt/libxml2/bin/xml2-config --with-xml2-dir=/usr/local/opt/libxml2 --with-xml2-lib=/usr/local/opt/libxml2/lib --with-xml2-include=/usr/local/opt/libxml2/include
```

## MySQL

If you get an error installing a mysql gem:

```
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

NOTE: Mostly I followed [this gist](https://gist.github.com/operatino/392614486ce4421063b9dece4dfe6c21), and [this gist](https://gist.github.com/fernandoaleman/ee3ac6957c2ba4f7d7d33a251d58b191#gistcomment-2735728).

## compaudit

You may need to run compaudit and fix some directory permissions.

    zsh compinit: insecure directories, run compaudit for list.
    Ignore insecure directories and continue [y] or abort compinit [n]? y
    /Users/pboling/.zshrc:12: command not found: rbenv

    $ compaudit
    $ sudo chmod g-w /usr/local/share/zsh/site-functions
    $ sudo chmod g-w /usr/local/share/zsh
