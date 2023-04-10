#!/usr/bin/env bash
# Originally from https://rimdev.io/hugo-extended-latest-install-script-for-macos/

set -x
set -e

# Find the latest Hugo from GitHub
echo '🐹 Starting Hugo Install / Update 🐹'
echo '      Note: Please be sure to have curl and grep installed'
echo ''

url=$(curl -s "https://api.github.com/repositories/11180687/releases/latest" | grep -o 'https://.*hugo_extended_.*_darwin-universal.tar.gz')
echo '✅ Found latest version'

curl -s $url -L -o hugo_latest.tar.gz
echo '✅ Download complete: ' $url

sudo tar -zxf hugo_latest.tar.gz -C /usr/local/bin
sudo rm /usr/local/bin/README.md
sudo rm /usr/local/bin/LICENSE
echo '✅ Extracted to /usr/local/bin'

rm hugo_latest.tar.gz
echo '✅ Removed downloaded artifacts'

echo ''
echo '👉 Current Version' $(hugo version)

echo ''
echo '🎉🎉🎉 Happy Hugo-ing! 🎉🎉🎉'
