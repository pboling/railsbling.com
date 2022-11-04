+++
date = "2022-11-04T00:54:16-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "Clojourner in a foreign land"
type = "page"

+++

# I'm loving Clojure & Rust & SvelteJS (and still Ruby!)

I read a lot, try to stay abreast of technology trends, and currently the momentum is behind Clojure, Rust,
and SvelteJS.
I will be writing more about them as I explore.
This is the first of a new series where I will document this journey.

When I began my computer programming career I dabbled in dozens of languages.
My first role was as a "Network Systems Developer", and in that capacity I was creating solutions for all
sorts of issues in all sorts of environments, which called for me to get comfortable with at least a dozen languages.
My wide experimentation with languages mostly ended once I went deep on Ruby, becoming an expert in that one language.

Two decades later, it is high time that I look around and see what has become of the language landscape,
starting with Clojure.

## Clojure

First, `asdf` is a wonderful, and under-evangelized, software-agnostic version manager.
What I mean by software-agnostic is it can version manage *any* software.
Coming from Ruby you may be familiar with rvm, rbenv, or chruby.
`asdf` eclipses them all, because not only does it serve as a Ruby version manager (using `ruby-build` under the hood),
but it also can manage all your other software tools.  Need different versions of Redis, PostgreSQL, MySQL, Java,
Clojure, Python, Elasticsearch, etc. for different projects, or even the same project, for testing dependency upgrades?
`asdf` is your new best friend.  It has plugins for every software tool you can think of.
Did you notice I mentioned Java and Clojure in there? ;)

Let's go!

## `asdf` setup

1. [Setup `asdf`](https://asdf-vm.com/) if you haven't already.
2. Java - Set up the [asdf-java plugin](https://github.com/halcyon/asdf-java) as instructed. The dependencies mentioned can be installed with `homebrew`.
3. Clojure - Set up the [asdf-clojure plugin](https://github.com/asdf-community/asdf-clojure) as instructed.

I went with the latest available versions of both (which may be different for you, future-dweller!):

```shell
asdf list-all java
asdf install java openjdk-19.0.1
asdf global java openjdk-19.0.1

# Make sure to follow the post-install instructions for env setup

asdf list-all clojure
asdf install clojure 1.11.1.1189
asdf global clojure 1.11.1.1189

# Make sure to follow the post-install instructions for env setup
```

## Setup Intellij IDEA

I subscribe to JetBrains full suite of IDEs, so I can use any of them and any language as needed,
and I highly recommend it. My blog is Hugo (which is Go), so I use GoLand for that.
I use RubyMine for Ruby code.  I use WebStorm for Javascript / SvelteJS / front end code.
I use PhpStorm for the times when I cross paths with WordPress.
And now I use IntelliJ IDEA for Java / Clojure!

These are the relevant plugins I use:

* Cursive
* Gitmoji Plus: Commit Button
* GitToolBox
* Json Parser
* Rainbow Brackets
* String Manipulation

Config preferences to use the correct Java.
Jetbrains IDEs all support `asdf` tools, so the version installed by `asdf` will be one of the options
(and probably significantly more recent than whatever one you had before `asdf-java` entered your life).

## Start a new Clojure project

First project is a tool that will help me automate management of badges across my many posts announcing new releases of a project.
It is so much work to manage that it had caused me to fail to post release announcements for the last many several releases of various projects, and that's a broken state that needs to be fixed.

Follow along with the [`badger` project on Codeberg](https://codeberg.org/pboling/badger) if you are interested!