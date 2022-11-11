# XlsFunction

[![badge](https://img.shields.io/gem/v/xls_function?style=for-the-badge)](https://rubygems.org/gems/xls_function)

Excel-like Function Evaluator. You can get modified value by evaluated function string.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xls_function'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install xls_function

## Usage

```ruby
  str = 'IF(LEFT("sample", 1) = "s", "this is sample", "what is this?")'
  result = XlsFunction.evaluate(str)
  p result # => "this is sample"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/moneyforward/xls_function. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](./CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [Apache License, Version 2.0](https://opensource.org/licenses/Apache-2.0).

## Code of Conduct

Everyone interacting in the XlsFunction project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/moneyforward/xls_function/blob/master/CODE_OF_CONDUCT.md).
