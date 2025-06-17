source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in lpt.gemspec.
gemspec

gem "puma"

gem "pg"

gem "sprockets-rails"

gem "faraday"
# Start debugger with binding.b [https://github.com/ruby/debug]
gem "debug", ">= 1.0.0"

## required for fixing rails 7.0.8.1 issues, especially outside of tree
gem "concurrent-ruby", "<=1.3.4"