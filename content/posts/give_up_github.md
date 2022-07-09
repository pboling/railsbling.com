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

## I Am Using GitHub Under Protest

Update: I had posted this to dev.to originally, and it was the most popular thing I've written there by orders of magnitude.  So I guess they had no choice by to mark my account as spam.

Github's decision to sponsor me is so recent that I haven't been able to cash out the $550 payment yet.

In spite of that, I can't leave the platform fast enough.  I certainly do not have the spare-time to move **hundreds** of projects to a new home... but I'm getting started.

GitHub is a proprietary, trade-secret system that is not Free and Open Source Software (FOSS).  I am [deeply concerned](https://sfconservancy.org/blog/2022/jun/30/give-up-github-launch/) about using a proprietary system like GitHub to develop FOSS projects.

# Micro Issues

1. A recent proposal to extend Github-flavored Markdown ([ref](https://github.com/github-community/community/discussions/16925#discussioncomment-3095850))
    - Literally [breaks](https://github.com/github-community/community/discussions/16925#discussioncomment-3014438) regular markdown syntax of links in headings.
    - [English-only](https://github.com/github-community/community/discussions/16925#discussioncomment-3086634)
    - Incompatible with Semantic HTML (POSH) (by [abusing](https://github.com/github-community/community/discussions/16925#discussioncomment-2830438) the `blockquote` tag; this also raises issues of [accessibility](https://github.com/github-community/community/discussions/16925#discussioncomment-3095850))
    - Incompatible with existing [Markdown standards proposals](https://github.com/github-community/community/discussions/16925#discussioncomment-2791869)
    - Rudely ignorant of the community-centered approach to [extending Markdown](https://github.com/github-community/community/discussions/16925#discussioncomment-3095850), which, ironically, [Github started](https://github.com/github-community/community/discussions/16925#discussioncomment-3101018)
    - [Contributes](https://github.com/github-community/community/discussions/16925#discussioncomment-2975948) to vendor [lock-in](https://github.com/github-community/community/discussions/16925#discussioncomment-2806570).
    - Will force countless volunteer FOSS developers to waste time [adding compatibility](https://github.com/github-community/community/discussions/16925#discussioncomment-3086904) to their projects that use Markdown and attempt to support GFM.
2. More than 2 years of ignoring requests to add an important feature (`allow-failure`) to Github Actions ([ref](https://github.com/actions/toolkit/issues/399), [ref](https://github.com/github-community/community/discussions/15452)).  When not ignoring, Github is [completely misunderstanding](https://github.com/actions/toolkit/issues/399#issuecomment-607450398) the feature.  How are those building Github Actions so deeply **unfamiliar** with core features of competing CI platforms.
3. Latest iteration of [Achievements](https://github.com/github-community/community/discussions/18153#discussioncomment-2935669) was bad.
4. Microsoft (parent of Github) has decided to [ban commercial open source](https://sfconservancy.org/blog/2022/jul/07/microsoft-bans-commerical-open-source-in-app-store/) apps from their app store.

---

# Macro Issues

For a broad perspective on the practical issues, I can't make the argument any better than it [was in 2010](https://mako.cc/writing/hill-free_tools.html), and recently by [Software Freedom Conservancy](https://sfconservancy.org/), [here](https://sfconservancy.org/blog/2022/jun/30/give-up-github-launch/) and [here](https://sfconservancy.org/GiveUpGitHub/).  Github has crossed the Rubicon.

<figure>
  <a href="https://sfconservancy.org/GiveUpGitHub/"><img align="left" width="50%" src="https://sfconservancy.org/img/GiveUpGitHub.png" alt="Logo of the GiveUpGitHub campaign"></a>
  <figcaption>For those who've never heard of the <a href="https://sfconservancy.org/GiveUpGitHub/">Software Freedom Conservancy</a>, <a href="https://sfconservancy.org/projects/current/">member projects</a> include: <a href="https://backdropcms.org/">Backdrop CMS</a>, <a href="https://www.coreboot.org/">Coreboot</a>, <a href="http://darcs.net/">Darcs</a>, <a href="https://git-scm.com/">git</a> (yes, <em>the</em> git in Github), <a href="https://inkscape.org/">Inkscape</a>, <a href="https://microblocks.fun/">MicroBlocks</a>, <a href="https://www.mercurial-scm.org/">Mercurial</a>, <a href="https://openwrt.org/">OpenWRT</a>, <a href="https://phpmyadmin.net/">phpMyAdmin</a>, <a href="http://qemu.org/">QEMU</a>, <a href="https://www.samba.org/samba/">Samba</a>, <a href="http://seleniumhq.org/">Selenium</a>, <a href="http://squeak.org/">Squeak</a> and <a href="http://www.winehq.org/">Wine</a>, among others.
  </figcaption>
</figure>

## What about community?

I am interested in people's thoughts on where to go next.  Community involvement matters for open source projects, and I have dozens of them that could be affected, the biggest being [`oauth`](https://rubygems.org/gems/oauth) and [`oauth2`](https://rubygems.org/gems/oauth2) Ruby gems.

Regarding fragmentation, hopefully it will be resolved by federation, which is to source forges (like Github) what git was to version control (i.e. makes it distributed, at least in theory).

It looks like Gitea, Codeberg and Hostea will [join the fediverse](https://forgefriends.org/blog/2022/06/30/2022-06-state-forge-federation/) soon, within a year, and there are projects that will integrate Github with the fediverse as well (i.e. federate Github commits, PRs, issues, etc).

## Questions

- Have any major Ruby projects already left?
- Anyone have experience with mirroring to multiple git hosts, as that might be a temp bridge solution?
- Self-hosting a git service?
- Thoughts on the centralized git hosting providers recommended by SF Conservancy?

## Poll

*Where to take projects (e.g `oauth2`)?*

- https://github.com/oauth-xx/oauth2/discussions/622
