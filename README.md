# Social Market

- https://socialmarket-it.herokuapp.com

## Local setup

```
$ docker-compose up
$ bundle install
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
