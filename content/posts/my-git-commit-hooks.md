+++
date = "2015-09-11T15:23:46-07:00"
draft = false
title = "My Git Commit Hooks"
tags = [ "Development", "git", "process" ]
categories = [ "Development", "howto", "git" ]
series = [ "Rails Project Setup" ]

+++

I quite envy a nice commit message.  The [Rails](https://github.com/rails/rails) project has [rules about commit messages](http://edgeguides.rubyonrails.org/contributing_to_ruby_on_rails.html#commit-your-changes) that are tops. [This is a great example](https://github.com/pboling/rails/commit/bec65fa261b9803c19edbbe9dc89836e1edf78c7) from a great developer I know, which got merged into core.

So now on my own projects I have cribbed, tweaked, and automated a tiny bit of of that sweet, sweet commit message honey.

## Naming your branch

* Step 1
  - I name my branches with a prefix that is one of: "hotfix", "bug", "feature", or "candy".
* Step 2
  - A `/` is totally legit in a branch name.
* Step 3
  - The Story ID.  I never commit without first creating a story to which the changes will be connected and later, tested.
* Step 4
  - A `-` really helps to separate things.
* Step 5
  - A dasherized, underscored, or mishmash of both, description of the work in the branch

Here's an example: `bug/102551510-explosion-in-the-fudge-factory-spec-suite-fix`

## Automating a commit message suffix\*

Given a nice branch name like that, I can extract information from it, and automatically add it to my commit messages for $PROFIT.

I just drop this in my project's `.git/hooks/prepare-commit-msg`:

```
#!/usr/bin/env ruby
# vim: set syntax=ruby

# branches should be named like:
#	<story_type>/<story_id>-explosion-in-the-fudge-factory-spec-suite-fix
#	where story type is one of "hotfix", "bug", "feature", "candy"
#
branch = `git branch 2> /dev/null | grep -e ^* | awk '{print $2}'`
regex = /^(?<story_type>(hotfix)|(bug)|(feature)|(candy))\/(?<story_id>\d{8,})-.+\Z/
match_data = branch.match(regex)

# NOTE: `match` will return nil if match fails, otherwise an instance of MatchData.
# If not nil then we are assured matches for both regex capture groups
# match_data_or_nil[:story_type] will be one of "hotfix", "bug", "feature", "candy"
# match_data_or_nil[:story_id] will be a numeric string

if !match_data.nil?
  commit_msg = IO.read(ARGV[0])
  unless commit_msg.include?(match_data[:story_id])
    commit_msg = <<EOS
#{commit_msg.strip}
[#{match_data[:story_type]}][#{match_data[:story_id]}]
EOS
    File.open(ARGV[0], 'w') do |file|
      file.print commit_msg
    end
  end
end
```
\* Why a suffix?  Because the information being added is most useful for searching through commit messages in a long history.  Not as useful for reading in a PR on github, which shows the first *so many* characters from each commit message only, and if prefixed it would push important information below the ellipses fold.

## Testing the commit message suffix

Automation is no good without testing or you might just automate badness, and that's worse than no automation at all.

So I drop this in my `.git/hooks/commit-msg`:

```
#!/usr/bin/env ruby
# vim: set syntax=ruby

denied = <<EOM

Oh snap, think again...

 ______    _______      ___  _______  _______  _______  _______  ______   __
|    _ |  |       |    |   ||       ||       ||       ||       ||      | |  |
|   | ||  |    ___|    |   ||    ___||       ||_     _||    ___||  _    ||  |
|   |_||_ |   |___     |   ||   |___ |       |  |   |  |   |___ | | |   ||  |
|    __  ||    ___| ___|   ||    ___||      _|  |   |  |    ___|| |_|   ||__|
|   |  | ||   |___ |       ||   |___ |     |_   |   |  |   |___ |       | __
|___|  |_||_______||_______||_______||_______|  |___|  |_______||______| |__|


Did you forget a Tracker ID?
Example: git commit -m "I just fixed a bug. [12345678]"

EOM

full_text = File.read(ARGV[0])
if full_text =~ /\[\d{8,}\]/
  exit 0
else
  puts denied
  exit 1
end
```

\* Note: In the regex in both scripts I have a test for >= 8 digits.  That's to match the format of my story IDs which are always at least 8 digits.  Your story ID format may vary.
