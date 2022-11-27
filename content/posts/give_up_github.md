+++
date = "2022-07-10T05:18:30+07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "I'm Leaving Github"
tags = [ "development", "ruby", "git", "github", "dvcs", "floss", "federation" ]
categories = [ "development", "tools", "git", "floss", "federation" ]
series = [ "#GiveUpGithub" ]

+++
<div id="badges">

[![Follow Me on Twitter](https://img.shields.io/badge/PeterBoling-blue?style=plastic&logo=linkedin)](http://www.linkedin.com/in/peterboling)
[![Follow Me on LinkedIn](https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow)](http://twitter.com/intent/user?screen_name=galtzo)
[![Published Rubygems](https://img.shields.io/gem/u/pboling.svg)](https://rubygems.org/profiles/pboling)

</div>

## I Am Using GitHub Under Protest

Github's decided to sponsor me, because they rely on my tools.

In spite of that, I'm leaving.  Why?  I certainly do not have the spare-time to move **hundreds** of projects to a new home... but I'm getting started.

# Some Issues

1. A recent proposal to extend Github-flavored Markdown ([ref](https://github.com/github-community/community/discussions/16925#discussioncomment-3095850))
   - Literally [breaks](https://github.com/github-community/community/discussions/16925#discussioncomment-3014438) regular markdown syntax of links in headings.
   - [English-only](https://github.com/github-community/community/discussions/16925#discussioncomment-3086634)
   - Incompatible with Semantic HTML (POSH) (by [abusing](https://github.com/github-community/community/discussions/16925#discussioncomment-2830438) the `blockquote` tag; this also raises issues of [accessibility](https://github.com/github-community/community/discussions/16925#discussioncomment-3095850))
   - Incompatible with existing [Markdown standards proposals](https://github.com/github-community/community/discussions/16925#discussioncomment-2791869)
   - Ignores the community-centered approach to [extending Markdown](https://github.com/github-community/community/discussions/16925#discussioncomment-3095850), which, ironically, [Github started](https://github.com/github-community/community/discussions/16925#discussioncomment-3101018)
   - [Contributes](https://github.com/github-community/community/discussions/16925#discussioncomment-2975948) to vendor [lock-in](https://github.com/github-community/community/discussions/16925#discussioncomment-2806570).
   - Will force countless volunteer FOSS developers to waste time [adding compatibility](https://github.com/github-community/community/discussions/16925#discussioncomment-3086904) to their projects that use Markdown and attempt to support GFM.
2. More than 2 years of ignoring requests to add an important feature (`allow-failure`) to Github Actions ([ref](https://github.com/actions/toolkit/issues/399), [ref](https://github.com/github-community/community/discussions/15452)).  When not ignoring, Github is [completely misunderstanding](https://github.com/actions/toolkit/issues/399#issuecomment-607450398) the feature.  How are those building Github Actions so deeply **unfamiliar** with core features of competing CI platforms.
3. Latest iteration of [Achievements](https://github.com/github-community/community/discussions/18153#discussioncomment-2935669) was bad.
4. Microsoft (parent of Github) has decided to [ban commercial open source](https://sfconservancy.org/blog/2022/jul/07/microsoft-bans-commerical-open-source-in-app-store/) apps from their app store.

---

## What about community?

I am interested in people's thoughts on where to go next.  Community involvement matters for open source projects, and I have dozens of them that could be affected, the biggest being [`oauth`](https://rubygems.org/gems/oauth) and [`oauth2`](https://rubygems.org/gems/oauth2) Ruby gems.

Regarding fragmentation, hopefully it will be resolved by federation, which is to source forges (like Github) what git was to version control (i.e. makes it distributed, at least in theory).

It looks like Gitea, Codeberg and Hostea will [join the fediverse](https://forgefriends.org/blog/2022/06/30/2022-06-state-forge-federation/) soon, within a year, and there are projects that will integrate Github with the fediverse as well (i.e. federate Github commits, PRs, issues, etc).

I'm interested in your thoughts, leave a comment below!