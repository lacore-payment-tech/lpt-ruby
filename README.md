# LPT

A Ruby client for interacting with the [LPT API](https://lpt.io)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add lpt-ruby

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install lpt-ruby

## Usage

Configure the LPT Client

    Lpt.api_username = "LUSXXXXXXXXXXXXXXXXX"
    Lpt.api_password = "XXXXXXXXXXXXXXXXXXXX"
    Lpt.merchant = "LMRXXXXXXXXXXXXXXXXXXXX"
    Lpt.entity = "LENXXXXXXXXXXXXXXXXXXXX"
    Lpt.environment = Lpt::Environment::STAGING

The available environments are

    Lpt::Environment::PRODUCTION
    Lpt::Environment::DEMO
    Lpt::Environment::STAGING
    Lpt::Environment::SANDBOX
    Lpt::Environment::NEXT
    Lpt::Environment::IVV
    Lpt::Environment::TEST
    Lpt::Environment::DEV

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bundle exec rake` to run the tests and linting. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lacore-payment-tech/lpt-ruby.
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [code of conduct](https://github.com/lacore-payment-tech/lpt-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lpt::Ruby project's codebases, issue trackers, chat
rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lacore-payment-tech/lpt-ruby/blob/main/CODE_OF_CONDUCT.md).
