+++
date = "2021-11-10T01:00:00-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "New Release of oauth: Version 0.5.8"
tags = [ "development", "ruby", "rails", "rubygems", "oauth", "authentication" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

# oauth version 0.5.8 is Released

| Project                    |  Ruby Oauth                |
|--------------------------- |--------------------------- |
| name, license, docs        |  [![RubyGems.org](https://img.shields.io/badge/name-oauth-brightgreen.svg?style=flat)][rubygems] [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)][license-ref] [![RubyDoc.info](https://img.shields.io/badge/documentation-rubydoc-brightgreen.svg?style=flat)][documentation] |
| version & downloads        |  [![Version](https://img.shields.io/gem/v/oauth.svg)][rubygems] [![Total Downloads](https://img.shields.io/gem/dt/oauth.svg)][rubygems] [![Downloads Today](https://img.shields.io/gem/rd/oauth.svg)][rubygems] [![Homepage](https://img.shields.io/badge/source-github-brightgreen.svg?style=flat)][source] [![Stars](https://img.shields.io/github/stars/oauth-xx/oauth-ruby.svg?style=social)][stargazers]|
| dependencies & linting     |  [![Depfu](https://badges.depfu.com/badges/d570491bac0ad3b0b65deb3c82028327/count.svg)][depfu] [![lint status](https://github.com/oauth-xx/oauth-ruby/actions/workflows/style.yml/badge.svg)][actions] |
| unit tests                 |  [![supported rubies](https://github.com/oauth-xx/oauth-ruby/actions/workflows/supported.yml/badge.svg)][actions] [![unsupported status](https://github.com/oauth-xx/oauth-ruby/actions/workflows/unsupported.yml/badge.svg)][actions] |
| coverage & maintainability |  [![Test Coverage](https://api.codeclimate.com/v1/badges/3cf23270c21e8791d788/test_coverage)][climate_coverage] [![codecov](https://codecov.io/gh/oauth-xx/oauth-ruby/branch/master/graph/badge.svg?token=4ZNAWNxrf9)][codecov_coverage] [![Maintainability](https://api.codeclimate.com/v1/badges/3cf23270c21e8791d788/maintainability)][climate_maintainability] [![Maintenance Policy](https://img.shields.io/badge/maintenance-policy-brightgreen.svg?style=flat)][security] |
| resources                  |  [![Discussion](https://img.shields.io/badge/discussions-github-brightgreen.svg?style=flat)][gh_discussions] [![Mailing List](https://img.shields.io/badge/group-mailinglist.svg?style=social&logo=google)][mailinglist] [![Join the chat at https://gitter.im/oauth-xx/oauth-ruby](https://badges.gitter.im/Join%20Chat.svg)][chat] [![Blog](https://img.shields.io/badge/blog-railsbling-brightgreen.svg?style=flat)][blogpage] [![Network](https://img.shields.io/github/forks/oauth-xx/oauth-ruby.svg?style=social)][network] |
| Spread ~♡ⓛⓞⓥⓔ♡~         |  [![Open Source Helpers](https://www.codetriage.com/oauth-xx/oauth-ruby/badges/users.svg)][code_triage] [![Liberapay Patrons](https://img.shields.io/liberapay/patrons/pboling.svg?logo=liberapay)][liberapay_donate] [![Sponsor Me](https://img.shields.io/badge/sponsor-pboling.svg?style=social&logo=github)][gh_sponsors] [🌏][aboutme] [👼][angelme] [💻][coderme] [🌹][politicme] [![Tweet @ Peter][followme-img]][tweetme] |

## [0.5.8] 2021-11-10
### Added

* Added more documentation files to packaged gem, e.g. SECURITY.md, CODE_OF_CONDUCT.md

### Fixed

* Removed reference to RUBY_VERSION from gemspec, as it depends on rake release, which is problematic on some ruby engines. (by @pboling)

[0.5.8]: https://github.com/oauth-xx/oauth-ruby/releases/tag/v0.5.8

[comment]: <> (Following links are used by Homepage)

[network]: https://github.com/oauth-xx/oauth-ruby/network
[stargazers]: https://github.com/oauth-xx/oauth-ruby/stargazers

[comment]: <> (Following links are used by README, CONTRIBUTING, Homepage)

[conduct]: https://github.com/oauth-xx/oauth-ruby/blob/master/CODE_OF_CONDUCT.md
[contributing]: https://github.com/oauth-xx/oauth-ruby/blob/master/CONTRIBUTING.md
[contributors]: https://github.com/oauth-xx/oauth-ruby/graphs/contributors
[mailinglist]: http://groups.google.com/group/oauth-ruby
[source]: https://github.com/oauth-xx/oauth-ruby/

[comment]: <> (Following links are used by README, Homepage)

[aboutme]: https://about.me/peter.boling
[actions]: https://github.com/oauth-xx/oauth-ruby/actions
[angelme]: https://angel.co/peter-boling
[blogpage]: http://www.railsbling.com/tags/oauth/
[chat]: https://gitter.im/oauth-xx/oauth-ruby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge
[climate_coverage]: https://codeclimate.com/github/oauth-xx/oauth-ruby/test_coverage
[climate_maintainability]: https://codeclimate.com/github/oauth-xx/oauth-ruby/maintainability
[code_triage]: https://www.codetriage.com/oauth-xx/oauth-ruby
[codecov_coverage]: https://codecov.io/gh/oauth-xx/oauth-ruby
[coderme]:http://coderwall.com/pboling
[depfu]: https://depfu.com/github/oauth-xx/oauth-ruby?project_id=22868
[documentation]: https://rubydoc.info/github/oauth-xx/oauth-ruby
[followme-img]: https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow
[gh_discussions]: https://github.com/oauth-xx/oauth-ruby/discussions
[gh_sponsors]: https://github.com/sponsors/pboling
[license]: https://github.com/oauth-xx/oauth-ruby/blob/master/LICENSE
[license-ref]: https://opensource.org/licenses/MIT
[liberapay_donate]: https://liberapay.com/pboling/donate
[politicme]: https://nationalprogressiveparty.org
[pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[rubygems]: https://rubygems.org/gems/oauth
[security]: https://github.com/oauth-xx/oauth-ruby/blob/master/SECURITY.md
[semver]: http://semver.org/
[tweetme]: http://twitter.com/galtzo
