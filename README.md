# beatrix-kiddo

[![Code Climate](https://codeclimate.com/github/ktravers/beatrix-kiddo/badges/gpa.svg)](https://codeclimate.com/github/ktravers/beatrix-kiddo)

A Rails-based wedding website to help manage everyone on your list.

## Setup

requires [Ruby 2.3.1](https://www.ruby-lang.org/en/documentation/installation/) and [Rails 4.0.0+](http://guides.rubyonrails.org/getting_started.html)

#### Setting up the app locally

1. `git clone` repo to your local machine
2. cd into `beatrix-kiddo` directory
3. run `bundle install`
4. add `.env` file at root level of project directory. use `example.env` for reference

#### Setting up the local db

1. add `config/database.yml`. use `example.database.yml` for reference
2. update `seeds.db` with desired event names
3. add CSV file 'invites.csv' at root level of project directory

  ```
  # CSV columns should be organized as follows with events in order left to right from first to last:
  #
  # First name | Last name | Email              | Save The Date | Engagement Party | etc...
  # ---------------------------------------------------------------------------------------
  # Beatrix    | Kiddo     | bride@thebride.com | yes           | yes              | yes
  ```
4. run `rake db:create; rake db:migrate; rake db:seed`

## Contributing

#### Bug reports

Please log issues on this repo. Be sure to include:

1. Clear title and description of the bug
  - Keep the title concise, but provide clear info in the description below.
2. Steps to reproduce the problem
  - Start from the beginning, and provide any necessary context.
3. System/version information (your OS version, browser information, etc.)
4. Full text of any error messages

#### Feature requests welcome.

Please submit as a new issue.

#### Pull requests

See [`/issues`](https://github.com/ktravers/beatrix-kiddo/issues) for outstanding tickets.

1. Fork this repo (https://github.com/ktravers/beatrix-kiddo/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request
