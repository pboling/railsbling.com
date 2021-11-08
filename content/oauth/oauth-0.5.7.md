+++
date = "2021-11-07T01:00:00-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "New Release of oauth: Version 0.5.7"
tags = [ "development", "ruby", "rails", "rubygems", "oauth", "authentication" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

# oauth version 0.5.7 is Released

| Project                    |  Ruby Oauth                |
|--------------------------- |--------------------------- |
| name, license, docs        |  [![RubyGems.org](https://img.shields.io/badge/name-oauth-brightgreen.svg?style=flat)][rubygems] [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)][license-ref] [![RubyDoc.info](https://img.shields.io/badge/documentation-rubydoc-brightgreen.svg?style=flat)][documentation] |
| version & downloads        |  [![Version](https://img.shields.io/gem/v/oauth.svg)][rubygems] [![Total Downloads](https://img.shields.io/gem/dt/oauth.svg)][rubygems] [![Downloads Today](https://img.shields.io/gem/rd/oauth.svg)][rubygems] [![Homepage](https://img.shields.io/badge/source-github-brightgreen.svg?style=flat)][source] [![Stars](https://img.shields.io/github/stars/oauth-xx/oauth-ruby.svg?style=social)][stargazers]|
| dependencies & linting     |  [![Depfu](https://badges.depfu.com/badges/d570491bac0ad3b0b65deb3c82028327/count.svg)][depfu] [![lint status](https://github.com/oauth-xx/oauth-ruby/actions/workflows/style.yml/badge.svg)][actions] |
| unit tests                 |  [![supported rubies](https://github.com/oauth-xx/oauth-ruby/actions/workflows/supported.yml/badge.svg)][actions] [![unsupported status](https://github.com/oauth-xx/oauth-ruby/actions/workflows/unsupported.yml/badge.svg)][actions] |
| coverage & maintainability |  [![Test Coverage](https://api.codeclimate.com/v1/badges/3cf23270c21e8791d788/test_coverage)][climate_coverage] [![codecov](https://codecov.io/gh/oauth-xx/oauth-ruby/branch/master/graph/badge.svg?token=4ZNAWNxrf9)][codecov_coverage] [![Maintainability](https://api.codeclimate.com/v1/badges/3cf23270c21e8791d788/maintainability)][climate_maintainability] [![Maintenance Policy](https://img.shields.io/badge/maintenance-policy-brightgreen.svg?style=flat)][maintenancee_policy] |
| resources                  |  [![Discussion](https://img.shields.io/badge/discussions-github-brightgreen.svg?style=flat)][gh_discussions] [![Mailing List](https://img.shields.io/badge/group-mailinglist.svg?style=social&logo=google)][mailinglist] [![Join the chat at https://gitter.im/oauth-xx/oauth-ruby](https://badges.gitter.im/Join%20Chat.svg)][chat] [![Blog](https://img.shields.io/badge/blog-railsbling-brightgreen.svg?style=flat)][blogpage] [![Network](https://img.shields.io/github/forks/oauth-xx/oauth-ruby.svg?style=social)][network] |
| Spread ~♡ⓛⓞⓥⓔ♡~         |  [![Open Source Helpers](https://www.codetriage.com/oauth-xx/oauth-ruby/badges/users.svg)][code_triage] [![Liberapay Patrons](https://img.shields.io/liberapay/patrons/pboling.svg?logo=liberapay)][liberapay_donate] [![Sponsor Me](https://img.shields.io/badge/sponsor-pboling.svg?style=social&logo=github)][gh_sponsors] [🌏][aboutme] [👼][angelme] [💻][coderme] [🌹][politicme] [![Tweet @ Peter][followme-img]][tweetme] |

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

[COMMENT]: The following links are used by the table

[rubygems]: https://rubygems.org/gems/oauth

[depfu]: https://depfu.com/github/oauth-xx/oauth-ruby?project_id=22868

[actions]: https://github.com/oauth-xx/oauth-ruby/actions

[climate_coverage]: https://codeclimate.com/github/oauth-xx/oauth-ruby/test_coverage

[gh_discussions]: https://github.com/oauth-xx/oauth-ruby/discussions

[code_triage]: https://www.codetriage.com/oauth-xx/oauth-ruby

[license-ref]: https://opensource.org/licenses/MIT

[codecov_coverage]: https://codecov.io/gh/oauth-xx/oauth-ruby

[mailinglist]: http://groups.google.com/group/oauth-ruby

[liberapay_donate]: https://liberapay.com/pboling/donate

[aboutme]: https://about.me/peter.boling

[angelme]: https://angel.co/peter-boling

[coderme]:http://coderwall.com/pboling

[politicme]: https://nationalprogressiveparty.org

[followme-img]: https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow

[tweetme]: http://twitter.com/galtzo

[documentation]: https://rubydoc.info/github/oauth-xx/oauth-ruby/main

[source]: https://github.com/oauth-xx/oauth-ruby/

[climate_maintainability]: https://codeclimate.com/github/oauth-xx/oauth-ruby/maintainability

[network]: https://github.com/oauth-xx/oauth-ruby/network

[stargazers]: https://github.com/oauth-xx/oauth-ruby/stargazers

[chat]: https://gitter.im/oauth-xx/oauth-ruby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge

[blogpage]: http://www.railsbling.com/tags/oauth/

[maintenancee_policy]: https://guides.rubyonrails.org/maintenance_policy.html#security-issues

[gh_sponsors]: https://github.com/sponsors/pboling
