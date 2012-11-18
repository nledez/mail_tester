# Mail::Tester

A simple gem to test mail server config

## Installation

Add this line to your application's Gemfile:

    gem 'mail_tester'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mail_tester

## Usage

    @test = Mail::Tester::MailTester.new(@config['email_adress'], @config['password'])
    (message, nb) = @test.check_mail
    # message give you text return by server
    # nb give you number of message store on server
    (result, id) = @test.check_smtp
    # result give you message return by smtp server
    # id is the message id send by smtp server

## Testing

1. Clone it
2. Copy config.yml-sample to config.yml
3. Replace with your values in config.yml (dum_mail is a account with no mail)
4. "bundle exec rspec" launch Specs
5. "bundle exec guard" launch Guard with reload when modify files

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
