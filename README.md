# Social Market

- https://socialmarket-it.herokuapp.com

## Requirements

- Yarn
- Ruby 2.6
- Docker

## Local setup

```bash
$ docker-compose up
$ bundle install
$ yarn install
$ rails db:setup
$ rails server
```

## Seed administrators

```bash
$ heroku run rails db:seed
```

**And remember to update the password for each user mentioned in `db/seeds.rb`.**

## .env

```bash
$ cp env.sample .env
```

And then fill in the required values on `.env`.

### Slack Hook

A Slack hook is used (only in production) to send peculiar events to a Slack room. See the [documentation](https://api.slack.com/incoming-webhooks) for more information:

https://socialmarket-it.slack.com/messages/GH1TB9HJP/

### Rollbar

An access token (`post_server_item`) is needed to notify application errors:

https://rollbar.com/olistik/socialmarket/settings/access_tokens/

### Heroku

Save all the above mentioned ENV variables on Heroku so that they're available in production:

https://dashboard.heroku.com/apps/socialmarket-it/settings
