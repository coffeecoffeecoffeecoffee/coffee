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

```
bin/lint
```

## Deployment

Deployment of the master branch to Heroku is done automatically after CI passes.

## Tasks

`rake venues:hydrate` - Run hourly on :00 by Heroku Scheduler

## API

Endpoint: `https://coffeecoffeecoffee.coffee/api`

Documentation is available in `/docs`.

## Admin Instructions

### Creating an Event

1. Sign in
1. Visit https://coffeecoffeecoffee.coffee/admin
1. Click "New event"
1. Fill out the form _\*Note: Times in the admin panel are in UTC. Here's a handy time zone converter: https://www.timeanddate.com/worldclock/converter.html_
1. To find the Foursquare Venue ID, find the URL of the venue on Foursquare (e.g. https://foursquare.com/v/blue-bottle-coffee/5c3384fbacc5f5002c89a62c) and copy the Venue ID from the URL (e.g. `5c3384fbacc5f5002c89a62c`)
1. Click "Create event"

## License

This project is licensed under the GNU GPLv3 License -- see the
[LICENSE.md](LICENSE.md) file for details.
