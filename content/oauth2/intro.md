+++
date = "2018-09-21T11:00:00-07:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
authorgoogleplus = "https://plus.google.com/+PeterBoling/posts"
title = "Introducing oauth2"
tags = [ "Development", "Ruby", "rails", "RubyGems", "oauth2" ]
categories = [ "Development", "tools", "Ruby" ]
series = [ "Toolchain" ]
type = "docs"

+++

## A Ruby wrapper for the OAuth 2.0 protocol

[![Gem Version](http://img.shields.io/gem/v/oauth2.svg)][gem]
[![Total Downloads](https://img.shields.io/gem/dt/oauth2.svg)][gem]
[![Downloads Today](https://img.shields.io/gem/rt/oauth2.svg)][gem]
[![Network](https://img.shields.io/github/forks/oauth-xx/oauth2.svg?style=social)][network]
[![Stars](https://img.shields.io/github/stars/oauth-xx/oauth2.svg?style=social)][stargazers]
[![Build Status](http://img.shields.io/travis/oauth-xx/oauth2.svg)][travis]
[![Coverage Status](http://img.shields.io/coveralls/intridea/oauth2.svg)][coveralls]
[![Maintainability](https://api.codeclimate.com/v1/badges/688c612528ff90a46955/maintainability)][codeclimate-maintainability]
[![Depfu](https://badges.depfu.com/badges/6d34dc1ba682bbdf9ae2a97848241743/count.svg)][depfu]
[![Open Source Helpers](https://www.codetriage.com/oauth-xx/oauth2/badges/users.svg)][code-triage]
[![Chat](https://img.shields.io/gitter/room/oauth-xx/oauth2.svg)](https://gitter.im/oauth-xx/oauth2)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)][source-license]
[![Documentation](http://inch-ci.org/github/oauth-xx/oauth2.png)][inch-ci]

[gem]: https://rubygems.org/gems/oauth2
[network]: https://github.com/oauth-xx/oauth2/network
[stargazers]: https://github.com/oauth-xx/oauth2/stargazers
[travis]: http://travis-ci.org/oauth-xx/oauth2
[coveralls]: https://coveralls.io/r/intridea/oauth2
[codeclimate-maintainability]: https://codeclimate.com/github/oauth-xx/oauth2/maintainability
[depfu]: https://depfu.com/github/oauth-xx/oauth2
[source-license]: https://opensource.org/licenses/MIT
[inch-ci]: http://inch-ci.org/github/oauth-xx/oauth2
[code-triage]: https://www.codetriage.com/oauth-xx/oauth2

### Oauth2 gem is looking for additional maintainers. See [#307](https://github.com/oauth-xx/oauth2/issues/307).

A Ruby wrapper for the [OAuth 2.0 specification][oauth2-spec].

[oauth2-spec]: https://oauth.net/2/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oauth2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oauth2

## Resources

* [View Source on GitHub][code]
* [Report Issues on GitHub][issues]
* [Read More at the Wiki][wiki]

[code]: https://github.com/oauth-xx/oauth2
[issues]: https://github.com/oauth-xx/oauth2/issues
[wiki]: https://github.com/oauth-xx/oauth2/wiki

## Usage Example

```ruby
require 'oauth2'
client = OAuth2::Client.new('client_id', 'client_secret', :site => 'https://example.org')

client.auth_code.authorize_url(:redirect_uri => 'http://localhost:8080/oauth2/callback')
# => "https://example.org/oauth/authorization?response_type=code&client_id=client_id&redirect_uri=http://localhost:8080/oauth2/callback"

token = client.auth_code.get_token('authorization_code_value', :redirect_uri => 'http://localhost:8080/oauth2/callback', :headers => {'Authorization' => 'Basic some_password'})
response = token.get('/api/resource', :params => { 'query_foo' => 'bar' })
response.class.name
# => OAuth2::Response
```
