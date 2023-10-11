+++
date = "2023-10-11T11:45:00-06:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "Generate Gem Checksums"
tags = [ "development", "ruby", "rubygems", "security" ]
categories = [ "development", "tools", "ruby", "security" ]
series = [ "toolchain" ]
type = "posts"

+++

The example script on the RubyGems Guides Security page is short and sweet, and left a lot of work for me to do.
```ruby
require 'digest/sha2'
built_gem_path = 'pkg/gemname-version.gem'
checksum = Digest::SHA512.new.hexdigest(File.read(built_gem_path))
checksum_path = 'checksum/gemname-version.gem.sha512'
File.open(checksum_path, 'w' ) {|f| f.write(checksum) }
# add and commit 'checksum_path'
```

It doesn't create `SHA-256` checksums, which are the only ones displayed on the gem's landing page at RubyGems.org.
There is also a rake task (`rake build:checksum`) which _only_ creates an `SHA-256` checksum.
If I enhance the rake task, extending it to create both, and then it changes, (as I am hoping it will!)
then I'll need to undo the rake override hack in all my projects.

So I came up with a better version of the script I can use until I don't need it anymore.

```ruby
#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest/sha2"

# Final clause of Regex `(?=\.gem)` is a positive lookahead assertion
# See: https://learnbyexample.github.io/Ruby_Regexp/lookarounds.html#positive-lookarounds
# Used to pattern match against a gem package name, which always ends with .gem.
# The positive lookahead ensures it is present, and prevents it from being captured.
VERSION_REGEX = /((\d+\.\d+\.\d+)([-.][0-9A-Za-z-]+)*)(?=\.gem)/.freeze

gem_path_parts = ARGV.first&.split("/")

if gem_path_parts&.any?
  gem_name = gem_path_parts.last
  gem_pkg = File.join(gem_path_parts)
  puts "Looking for: #{gem_pkg.inspect}"
  gems = Dir[gem_pkg]
  puts "Found: #{gems.inspect}"
else
  gem_pkgs = File.join("pkg", "*.gem")
  puts "Looking for: #{gem_pkgs.inspect}"
  gems = Dir[gem_pkgs]
  raise "Unable to find gems #{gem_pkgs}" if gems.empty?

  # Sort by newest last
  # [ "my_gem-2.3.9.gem", "my_gem-2.3.11.pre.alpha.4.gem", "my_gem-2.3.15.gem", ... ]
  gems.sort_by! { |gem| Gem::Version.new(gem[VERSION_REGEX]) }
  gem_pkg = gems.last
  gem_path_parts = gem_pkg.split("/")
  gem_name = gem_path_parts.last
  puts "Found: #{gems.length} gems; latest is #{gem_name}"
end

checksum512 = Digest::SHA512.new.hexdigest(File.read(gem_pkg))
checksum512_path = "checksums/#{gem_name}.sha512"
File.write(checksum512_path, checksum512)

checksum256 = Digest::SHA256.new.hexdigest(File.read(gem_pkg))
checksum256_path = "checksums/#{gem_name}.sha256"
File.write(checksum256_path, checksum256)

version = gem_name[VERSION_REGEX]

git_cmd = <<~GIT_MSG
git add checksums/* && \
git commit -m "🔒️ Checksums for v#{version}"
GIT_MSG

puts <<~RESULTS
[GEM: #{gem_name}]
[VERSION: #{version}]
[CHECKSUM SHA256 PATH: #{checksum256_path}]
[CHECKSUM SHA512 PATH: #{checksum512_path}]

... Running ...

#{git_cmd}
RESULTS

# This will replace the current process with the git process, and exit.
# Any command placed after this will not be run:
#   See: https://www.akshaykhot.com/call-shell-commands-in-ruby
exec(git_cmd)

```

I may wrap this in a gem so I can easily install it on any machine...

I also submitted it as a [PR to Rubygems Guides](https://github.com/rubygems/guides/pull/325)
as a potential replacement for the old script.