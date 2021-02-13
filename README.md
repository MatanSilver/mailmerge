# Mailmerge

Mailmerge is a simple program that takes a list of template arguments in the form of a CSV file and populates an email template (in erb format) with those parameters.

You can use it to send a simple or formulaic email to multiple people and maintain some amount of personalization per person

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mailmerge'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mailmerge

## Usage

Example usage:

`mailmerge test.csv test.erb x@gmail.com password`

Example email template:

```
FROM: x@gmail.com
SUBJECT: <%= foo %>
TO: <%= @to_email %>

<%= bar %>
<%= baz %>

Regards,
Person
```

Example CSV:

```
to_email,foo,bar,baz
y@gmail.com,1,2,3
z@yahoo.com,4,5,6
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MatanSilver/mailmerge.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
