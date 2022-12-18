+++
date = "2022-12-17T08:13:30-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
hero = "images/posts/writing/fabio-oyXis2kALVg-unsplash-1980-1080-crop.png"
title = "Put the D in DVCS"
tags = [ "development", "ruby", "git", "github", "dvcs", "floss", "federation" ]
categories = [ "development", "tools", "git", "floss", "federation" ]
series = [ "#GiveUpGithub" ]

[menu]
[menu.sidebar]
name = "Put the D in DVCS"
identifier = "dvcs-thoughts-put-the-d-in"
parent = "dvcs-thoughts"
weight = 10

+++
<div id="badges">

[![Liberapay Patrons][⛳liberapay-img]][⛳liberapay]
[![Follow Me on LinkedIn][🖇linkedin-img]][🖇linkedin]
[![Follow Me on Twitter][🐦twitter-img]][🐦twitter]
[![Published Rubygems][💎rubygems-img]][💎rubygems]

</div>

[⛳liberapay-img]: https://img.shields.io/liberapay/patrons/pboling.svg?logo=liberapay
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇linkedin]: http://www.linkedin.com/in/peterboling
[🖇linkedin-img]: https://img.shields.io/badge/PeterBoling-blue?style=plastic&logo=linkedin
[🐦twitter]: http://twitter.com/intent/user?screen_name=galtzo
[🐦twitter-img]: https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow
[💎rubygems]: https://rubygems.org/profiles/pboling
[💎rubygems-img]: https://img.shields.io/gem/u/pboling.svg

## The problem with a Monopoly in a Decentralized ecosystem...

It kills the ecosystem.  Oh hello GitHub, I didn't notice you standing there.

## We need the D in DVCS

But how do you get it?

Pushing to multiple source code hosts needs to be as easy as `git push all`.

This process was primarily derived from a much more in depth
[StackOverflow](https://stackoverflow.com/a/14290145/213191).

```shell
$ git clone git://original/repo.git
$ git remote -v
origin  git://original/repo.git (fetch)
origin  git://original/repo.git (push)

# Add the original again, as a duplicate remote named "all":

$ git remote add all git://original/repo.git
$ git remote -v
all git://original/repo.git (fetch)               # <-- ADDED
all git://original/repo.git (push)                # <-- ADDED
origin  git://original/repo.git (fetch)
origin  git://original/repo.git (push)

# Add an alternate source host to "all"
# Unfortunately this changes the original push host for "all"...

$ git remote set-url --add --push all git://another/repo.git
$ git remote -v
all git://original/repo.git (fetch)
all git://another/repo.git (push)                 <-- CHANGED
origin  git://original/repo.git (fetch)
origin  git://original/repo.git (push)

# Rather than being strictly additive the push url was altered,
#   so in a strange twist we have to add back the original... again
#   to end up with multiple push hosts

$ git remote set-url --add --push all git://original/repo.git
$ git remote -v
all git://original/repo.git (fetch)
all git://another/repo.git (push)
all git://original/repo.git (push)                <-- ADDED
origin  git://original/repo.git (fetch)
origin  git://original/repo.git (push)
```

And there you have it!

```shell
$ git push all
```

# What source code forges (hosts) do I recommend?

- [SourceHut](https://sr.ht/~galtzo/)
- [CodeBerg](https://codeberg.org/pboling)
- [GitLab](https://gitlab.com/pboling)
- I'll add more later!

> [Hero image (cropped)](https://unsplash.com/photos/oyXis2kALVg) by [fabio](https://unsplash.com/@fabioha)
