# Shortener

A very simple URL shortener API. 

## Getting Started

### Dependencies 

Coded and tested using these versions:

* `apartment-2.1.0`
* `bundler-1.16.1`
* `factory-bot-4.8.2`
* `faker-1.8.7`
* `puma-3.11.2`
* `rails-5.1.5` (API only)
* `rspec-3.7.*`
* `ruby-2.3.1`
* `shoulda-matchers-3.1.2`
* `sqlite-1.3.13`

### Install

Should work with a standard bundle installation:

```bash
    $ bundle install
```

### Database

Create, migrate and seed the DB. Seeding it is important to ensure that tenants are
added by default.

```bash
    $ rails db:create; rails db:migrate; rails db:seed
```

### Hosts file

Because we use multi-tenancy with the apartment gem, you will want to add the following
to your `/etc/hosts` file:

```
127.0.0.1	t1.shortener.test
127.0.0.1	t2.shortener.test
```

### Test

Run the test suite using RSpec:

```bash
    $ bundle exec rspec
```

### Run

Run the server and have fun:

```bash
    $ rails s
```

## Using it

### Create a short URL

Create a new shortened URL by doing a `POST` to `/links`. Add an `original` parameter.

```bash
    $ curl -H "Content-Type: application/json"\
       -X POST -d '{ "original": "http://github.com" }'\
       http://t1.shortener.test:3000/links
```

You should get something like this:

```json
    {
        "id":2,
        "original":"http://github.com",
        "shortened":"ab6ywhd0",
        "subdomain":"t1",
        "created_at":"2018-03-04T20:37:21.665Z",
        "updated_at":"2018-03-04T20:37:21.665Z"
    }
```

Check the *shortened* value. That'll be your short URL. You can append it to the domain.

### Resolving a shortened URL

Resolve the shortened URL by doing a `GET` to the shortened value. From the example above,
assuming that the value is `ab6ywhd0`:

```bash
    $ curl http://t1.shortener.test:3000/ab6ywhd0
```