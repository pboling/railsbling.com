#!/usr/bin/env bash

set -x

# ENV setup
FAUXROOT=~/root

# Website Info
SITE_NAME=railsbling
SITE_TLD=com
SITE_DOMAIN="$SITE_NAME.$SITE_TLD"
SITE_URL="http://www.$SITE_DOMAIN"
# What is the theme?
THEME_NAME=toha

# Check that Hugo is installed and available at the expected path.
$FAUXROOT/usr/local/bin/hugo version
# I have my git repo replicated on my server, so this is a path to a repo (not a clone of a repo, an actual repo).
# You could change this to any kind of git-cloneable address.
# It doesn't need to be an actual repo path, just needs to be a cloneable thing.
SITE_REPO=$HOME/$SITE_NAME.git
# This temporary directory is used by the build process.
# We clone the (local) repo, and remote submodule theme everytime we update.
SITE_TMP=$HOME/tmp/$SITE_NAME
# Where the final, built, site will land, to be served on the  internet.
SITE_WWW=$HOME/$SITE_DOMAIN

# Clone into the temporary directories.
rm -rf "$SITE_TMP"
git clone "$SITE_REPO" "$SITE_TMP" --recurse-submodules

# Then build
$FAUXROOT/usr/local/bin/hugo --theme="$THEME_NAME" -s "$SITE_TMP" -d "$SITE_WWW" -b "$SITE_URL"
