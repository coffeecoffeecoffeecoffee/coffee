# ☕️

[![CircleCI](https://circleci.com/gh/jamescmartinez/coffee.svg?style=svg)](https://circleci.com/gh/jamescmartinez/coffee)

## Getting Started

### Prerequisites

- PostgreSQL

### Installing and Running

1. Make sure that all prerequisites are installed and running locally.
1. Run `bin/setup` to install dependencies and prepare the local database.
1. Run `rails s` to start the Rails server.

## Running the tests

```
rspec
```

## Linting

- `erblint --lint-all --autocorrect`
- `eslint .`
- `rubocop -Ra`

## Deployment

Deployment of the master branch to Heroku is done automatically after CI passes.

## Tasks

`rake venues:hydrate` - Run hourly on :00 by Heroku Scheduler

## License

This project is licensed under the GNU GPLv3 License -- see the
[LICENSE.md](LICENSE.md) file for details.

## Other

`User.where(email: "email@example.com").first.update(admin: true)` to add an
admin.
