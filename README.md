# Shortener [![Build Status](https://travis-ci.org/xnt/shortener.svg?branch=master) ](https://travis-ci.org/xnt/shortener)

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
    $ rake db:migrate; rake db:seed
```

### Hosts file

Because we use multi-tenancy with the apartment gem, you will want to add them to your 
`/etc/hosts` file:

```bash
    sudo -- sh -c -e "echo '127.0.0.1  t1.shortener.test t2.shortener.test' >> /etc/hosts"
```

### Test

Run the test suite using rake, which should hit rspec:

```bash
    $ rake
```

Alternatively:

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

Check the **shortened** value. That'll be your short URL. You can append it to the domain.

### Resolving a shortened URL

Resolve the shortened URL by doing a `GET` to the shortened value. From the example above,
assuming that the value is `ab6ywhd0`:

```bash
    $ curl http://t1.shortener.test:3000/ab6ywhd0
```

Which results in:

```bash
<html><body>You are being <a href="http://vplata.com">redirected</a>.</body></html>
```

You can see the actual server response by, for example, using Postman's Interceptor. As expected,
it's an `HTTP 302` with the appropriate `Location` response header.

Yay!