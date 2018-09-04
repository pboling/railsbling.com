+++
date = "2018-09-04T02:55:33-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "How I Go Again"
socialsharing = true
tags = [ "Development", "Go" ]
categories = [ "Development", "howto", "Go" ]
series = [ "Blogging" ]

+++

I am upgrading my [Hugo-based](https://gohugo.io/) blog from v0.15 to v0.48 (extended)!  Quite a mad leap.

## My Architecture

### Local is Mac

I am using a Mac for this process.

### Host is Dreamhost

My host is Dreamhost shared hosting, because I have an unlimited plan with them, and they are fundamentally awesome in my experience, but this guide will probably work for whatever host I have.  Deploying a static site means I don't need an app server that eats barbells for breakfast.

Configured my web directory as:

```
railsbling.com
```

### Build is Hugo

Hugo is very customizable.  Static doesn't need to mean boring.  There is also a wide range of possibilities with Javascript.

### Theme is redlounge

So nice right?!?  Have that [source](https://github.com/tmaiaroto/hugo-redlounge).

## HOW TO HUGO

Enough evangelism, let's talk code <i class='fas fa-code'></i>.

### Setup the Web Host

Setup my computer to connect to my server.

I used ssh keys and my `~/.ssh/config` so I can just `ssh <server name alias>` without any fuss.  The one thing that always trips me up when I setup a new server for key -based auth is the permissions on the `authorized_keys` file.

```
chmod 600 ~/.ssh/authorized_keys
```

So I ssh in to my server, and cleanup a bit from the old Hugo installs.

```
cd ~/debs
mkdir -p old_debs
mv hugo_0.14_amd64.deb old_debs/
mv hugo_0.15_amd64.deb old_debs/
```

I remove the old local hugo install.

```
rm -rf ~/root
```

Now I download and build the new Hugo.

```
root=~/root
wget https://github.com/gohugoio/hugo/releases/download/v0.48/hugo_extended_0.48_Linux-64bit.deb
mkdir -p $root
for d in *.deb; do echo "Installing $d"; dpkg -x $d $root; done
```

Then add Hugo's `bin` dir to my `$PATH`.
I had already done this for the initial install 2 years ago, but the path has changed, so I had to fix it.

```
echo 'export PATH=~/root/usr/local/bin:$PATH' >> ~/.bashrc
```

You will be pushing my site's git repo onto the server as a remote from my local.  So prepare <i class='fas fa-git'></i> for that.
I had already done this for the initial install 2 years ago, and it isn't changing, so I skipped this step.

```
mkdir ~/railsbling.git
cd ~/railsbling.git
git init
git config receive.denyCurrentBranch ignore 
```

Then checkout the theme I chose onto the server.  I picked `redlounge` (for now) from the options at the [master theme repo](https://github.com/gohugoio/hugoThemes).
I had already done this for the initial install 2 years ago, and it isn't changing, so I skipped this step...

```
git clone https://github.com/tmaiaroto/hugo-redlounge.git ~/redlounge.git
```

And instead I just went into my `redlounge.git` directory and did a `git pull`.

Then tweak for my needs and make it my `~/railsbling.git/.git/hooks/post-receive` <i class='fas fa-paste'></i>:
I had already done this for the initial install 2 years ago, but the path changed with the newer version of hugo (adds `local`).

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
$HOME/root/usr/local/bin/hugo --theme="redlounge" -s $SITE_TMP -d $SITE_WWW -b "http://www.railsbling.com"
rm -Rf $SITE_TMP
exit
```

### Setup Local Development

Homebrew continues to kick ass and take names.  Give it the name "hugo", and brew will kick its ass.

```
$ brew install hugo
...
==> Downloading https://homebrew.bintray.com/bottles/hugo-0.48.high_sierra.bottle.1.tar.gz
######################################################################## 100.0%
==> Pouring hugo-0.48.high_sierra.bottle.1.tar.gz
==> Caveats
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> Summary
🍺  /usr/local/Cellar/hugo/0.48: 32 files, 37.2MB
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
cd ~/Documents/hugo/railsbling
git clone --depth 1 --recursive https://github.com/gohugoio/hugoThemes.git themes
```

From the directory listing, pick a theme that has a name I am particularly drawn to, like "redlounge", and execute it without prejudice.

The following can be run from any directory, so I have it aliased as `bling` on my system.
```
hugo server --source ~/Documents/hugo/railsbling --buildDrafts --watch --theme redlounge --destination ~/Documents/hugo/drafts
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

Update: I am switching my theme to [`coder`](https://github.com/luizdepra/hugo-coder/)!
