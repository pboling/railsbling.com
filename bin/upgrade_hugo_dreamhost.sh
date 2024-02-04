#!/usr/bin/env bash
# Heavily Modified from https://rimdev.io/hugo-extended-latest-install-script-for-macos/

# Uncomment set -x for debugging, as it will print every command before running it.
set -x
# Script should DIE immediately if there an error code (non-zero) is returned by any command
set -e

# Find the latest Hugo from GitHub
echo '🐹 Starting Hugo Install / Update 🐹'
echo '      Note: Please be sure to have curl and grep installed'
echo ''

# Make directory for downloading the latest hugo extended
mkdir -p ~/debs
# Make directory to move previous versions of hugo extended
#   (for eventual cleanup/removal - not handled by this script)
mkdir -p ~/debs/old_debs
echo '✅ ~/debs and ~/debs/old_debs exist'

# Move previous version to old_debs
cd debs
mv *.deb old_debs
echo '✅ moved previous .deb to ~/debs/old_debs'

# Download latest version
url=$(curl -s "https://api.github.com/repositories/11180687/releases/latest" | grep -o 'https://.*hugo_extended_.*_linux-amd64.deb')
echo '✅ Found latest version'

curl -s $url -L -o hugo_latest.deb
echo '✅ Download complete: ' $url

for d in *.deb; do echo "📦 Installing $d"; dpkg -x $d $FAUXROOT; done
echo '✅ Install complete: hugo_latest.deb'
