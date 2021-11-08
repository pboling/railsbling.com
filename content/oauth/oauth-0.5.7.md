+++
date = "2021-11-08T01:00:00-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "New Release of oauth: Version 0.5.7"
tags = [ "development", "ruby", "rails", "rubygems", "oauth" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

# oauth version 0.5.7 is Released
## [0.5.7] 2021-11-02
### Added

* Setup Rubocop (#205, #208 by @pboling)
* Added CODE_OF_CONDUCT.md (#217, #218 by @pboling)
* Added FUNDING.yml (#217, #218 by @pboling)
* Added Client Certificate Options: :ssl_client_cert and :ssl_client_key (#136, #220 by @pboling)
* Handle a nested array of hashes in OAuth::Helper.normalize (#80, #221 by @pboling)

### Changed

* Switch from TravisCI to Github Actions (#202, #207, #176 by @pboling)
* Upgrade webmock to v3.14.0 (#196 by @pboling)
* Upgrade em-http-request to v1.1.7 (#173 by @pboling)
* Upgrade mocha to v1.13.0 (#193 by @pboling)
* HISTORY renamed to CHANGELOG.md, and follows Keep a Changelog (#214, #215 by @pboling)
* CHANGELOG, LICENSE, and README now ship with packaged gem (#214, #215 by @pboling)
* README.rdoc renamed to README.md (#217, #218 by @pboling)
* Require plaintext signature method by default (#135 by @confiks & @pboling)

### Fixed

* Fixed Infinite Redirect in v0.5.5, v0.5.6 (#186, #210 by @pboling)
* Fixed NoMethodError on missing leading slash in path (#194, #211 by @pboling)
* Fixed NoMethodError on nil request object (#165, #212 by @pboling)
* Fixed Unsafe String Comparison (#156, #209 by @pboling and @drosseau)
* Fixed typos in Gemspec (#204, #203, #208 by @pboling)
* Copyright Notice in LICENSE - added correct years (#217, #218 by @pboling)
* Fixed request proxy Class constant reference scopes - was missing `::` in many places (#225, #226 by @pboling)

### Removed

* Remove direct development dependency on nokogiri (#299 by @pboling)

[0.5.7]: https://github.com/oauth-xx/oauth-ruby/releases/tag/v0.5.7
