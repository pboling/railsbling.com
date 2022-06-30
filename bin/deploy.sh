#!/usr/bin/env bash

set -x

# ENV setup
FAUXROOT=~/root

# Website Info
SITE_NAME=railsbling
SITE_TLD=com
SITE_DOMAIN="$SITE_NAME.$SITE_TLD"
SITE_URL="http://www.$SITE_DOMAIN"

# Check that Hugo is installed and available at the expected path.
$FAUXROOT/usr/local/bin/hugo version
# I have my git repo replicated on my server, so this is a path to a repo (not a clone of a repo, an actual repo).
# You could change this to any kind of git-cloneable address.
# It doesn't need to be an actual repo path, just needs to be a cloneable thing.
SITE_REPO=$HOME/$SITE_NAME.git
# Same with the theme:
THEME_NAME=toha
THEME_REPO=$HOME/themes/$THEME_NAME.git
# These temporary directories are used by the build process.
# We clone the repo everytime we update, rather than git pull.
SITE_TMP=$HOME/tmp/$SITE_NAME
THEME_TMP=$HOME/tmp/$SITE_NAME/themes/$THEME_NAME
# rm -rf $SITE_TMP
# rm -rf $THEME_TMP
# Where the final, built, site will land, to be served on the  internet.
SITE_WWW=$HOME/$SITE_DOMAIN

# Grab latest theme
cd $THEME_REPO
cat .git/HEAD
git -C $THEME_REPO pull --rebase

# Clone into the temporary directories.
git clone $SITE_REPO $SITE_TMP
git clone $THEME_REPO $THEME_TMP

# Then build
$FAUXROOT/usr/local/bin/hugo --theme="$THEME_NAME" -s "$SITE_TMP" -d "$SITE_WWW" -b "$SITE_URL"

# Then Cleanup
# rm -rf $SITE_TMP
# rm -rf $THEME_TMP
