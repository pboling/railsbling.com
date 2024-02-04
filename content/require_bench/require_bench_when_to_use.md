+++
date = "2023-04-15T06:39:00-00:00"
draft = false
authorlink = "https://about.me/peter.boling"
authorlinktarget = "_blank"
authortwitter = "https://www.twitter.com/galtzo"
authorlinkedin = "https://www.linkedin.com/in/peterboling"
authorfacebook = "https://www.facebook.com/peter.boling"
title = "RequireBench: When do you use it?"
tags = [ "development", "ruby", "rails", "rubygems", "require_bench", "benchmarking" ]
categories = [ "development", "tools", "ruby" ]
series = [ "toolchain" ]
type = "docs"

+++

## RequireBench: When do you use it?

Upgrading an old application, I encountered the following code.

```ruby
# Uncomment the following monkey patch to debug "SystemStackError: stack level too deep" during boot up
module Kernel
  def require_and_print(string)
    puts string
    require_original(string)
  end

  alias_method :require_original, :require
  alias_method :require, :require_and_print
end
```

This is what `require_bench` was written for.  You don't need to add hacks like this to your code anymore!

OK, but why is the gem better than the hack?

I'm glad you asked!  Here are the top 5 reason.  I could list more, but I think these suffice.

1. 100% test coverage (line and branch).
2. 100% test coverage.
3. 100% test coverage.
4. 100% test coverage.
5. 100% test coverage.

Check it out!  Oh, that reminds me.

This is my latest project to adopt my new [D-in-DVCS paradigm][💎d-in-dvcs], so check _that_ out!

## 🛞 DVCS

This project does not trust any one version control hosting provider,
so it abides the principles of ["Distributed Version Control Systems"][💎d-in-dvcs]

Find this project on:

| Any            | Of               | These          | DVCSs          |
|----------------|------------------|----------------|----------------|
| [🐙hub][🐙hub] | [🧊berg][🧊berg] | [🛖hut][🛖hut] | [🧪lab][🧪lab] |

[comment]: <> ( DVCS LINKS )

[💎d-in-dvcs]: https://railsbling.com/posts/dvcs/put_the_d_in_dvcs/

[🧊berg]: https://codeberg.org/pboling/require_bench
[🐙hub]: https://github.com/pboling/require_bench
[🛖hut]: https://git.sr.ht/~galtzo/require_bench
[🧪lab]: https://gitlab.com/pboling/require_bench
