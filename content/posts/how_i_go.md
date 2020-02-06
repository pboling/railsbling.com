+++
date = "2015-08-31T00:55:47-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "How I Go"
socialsharing = true
tags = [ "development", "Go" ]
categories = [ "development", "howto", "Go" ]
series = [ "Blogging" ]

+++

I am relaunching my blog!  I have decided to use [Hugo](https://gohugo.io/) after much internal debate, and strong lobbying from all the sleazy corporate bag-men that are constantly trying to bribe me with buzz words <i class='fas fa-money'></i>.  I will always <i class='fas fa-heart'></i> Ruby and use it every day, but for my blog I gotta go.  So easy, static and fast!  As my first post I will document how I made this work.

## My Architecture

### Local is Mac

My workhorse is my heavily modified (via cover stickers) Macbook Pro.  I may replicate the setup on my linux box, and if I do I'll add notes for important tweaks to this process.

### Host is Dreamhost

My host is Dreamhost shared hosting, because I have an unlimited plan with them, and they are fundamentally awesome in my experience, but this guide will probably work for whatever host you have.  Deploying a static site means I don't need an app server that eats barbells for breakfast.

Configured my web directory as:

```
railsbling.com
```

### Build is Hugo

Hugo is very customizable and pluguzable, so I can add Disqus comments, and [SEO sharing bars to my posts](http://discuss.gohugo.io/t/hugo-seo-social-partials/353), and other cool stuff (all of which I have yet to tackle).  Static doesn't need to mean boring.  There is also a wide range of possibilities with Javascript.

### Theme is redlounge

Look nice right?!?  Have that [source](https://github.com/tmaiaroto/hugo-redlounge).

## HOW TO HUGO

Enough evangelism, let's talk code <i class='fas fa-code'></i>.

### Setup the Web Host

Setup my computer to connect to my server.

I used ssh keys and my `~/.ssh/config` so I can just `ssh <server name alias>` without any fuss.  The one thing that always trips me up when I setup a new server for key -based auth is the permissions on the `authorized_keys` file.

```
chmod 600 ~/.ssh/authorized_keys
```

Then on my server I will have to build Hugo, and then I call a friend I haven't spoken to in a while just to catch up.

```
root=~/root
mkdir -p ~/debs
cd ~/debs
wget https://github.com/spf13/hugo/releases/download/v0.14/hugo_0.14_amd64.deb
mkdir -p $root
for d in *.deb; do echo "Installing $d"; dpkg -x $d $root; done
```

Then add Hugo's `bin` dir to my `$PATH`

```
echo 'export PATH=~/root/usr/bin:$PATH' >> ~/.bashrc
```

I will be pushing my site's repo onto the server as a remote from my local.  So prepare <i class='fas fa-git'></i> for that.

```
mkdir ~/railsbling.git
cd ~/railsbling.git
git init
git config receive.denyCurrentBranch ignore 
```

Then checkout the theme I chose onto the server.  I picked `redlounge` (for now) from the options at the [master theme repo](https://github.com/gohugoio/hugoThemes).

```
git clone https://github.com/tmaiaroto/hugo-redlounge.git ~/redlounge.git
```

Then tweak for my needs and make it my `~/railsbling.git/.git/hooks/post-receive` <i class='fas fa-paste'></i>:

```
cat ~/railsbling.git/.git/hooks/post-receive

SITE_REPO=$HOME/railsbling.git
THEME_REPO=$HOME/redlounge.git
SITE_TMP=$HOME/tmp/railsbling
THEME_TMP=$HOME/tmp/railsbling/themes/redlounge
SITE_WWW=$HOME/railsbling.com

git clone $SITE_REPO $SITE_TMP
git clone $THEME_REPO $THEME_TMP
cd $SITE_TMP
$HOME/root/usr/bin/hugo --theme="redlounge" -s $SITE_TMP -d $SITE_WWW -b "http://www.railsbling.com"
rm -Rf $SITE_TMP
exit
```

### Setup Local Development

Homebrew continues to kick ass and take names.  Give it the name "hugo", and brew will kick its ass.

```lang=bash
brew install hugo
```

Create this website and move in.

```
hugo new railsbling.com ~/Documents/hugo/railsbling
cd ~/Documents/hugo/railsbling
```

Create some pages

```
hugo new about.md
hugo new cv.md
...
```

The top of each file before the `+++` is called the `frontmatter`, and it is the part where all the fancy config happens on a per post level, if any.  For now ignore that.

Below the `+++` is regular Markdown.  So Blaze that Fireball and write some stuff in there.

Install the themes.  Just grab them all initially so I can try out a bunch and find the one I like.

```
git clone --recursive https://github.com/spf13/hugoThemes themes
```

From the directory listing, pick a theme that has a name I am particularly drawn to, like "redlounge", and execute it without prejudice.

```
ls themes
hugo server --theme=redlounge --buildDrafts --watch
```

Now I have the site running locally.  Now comes the actual work.

Git it.

```
git init
git remote add live ssh://railsbling.com/home/<username>/railsbling.git
git add .
git commit -m "Hot Toddy"
git push --set-upstream live master
```

Like magic, and unless I missed something in my writeup, my new site will deploy and be live!
