# Iceberg (Alpha, Not released)

[![Build Status](https://travis-ci.org/adlerhsieh/iceberg.svg?branch=master)](https://travis-ci.org/adlerhsieh/iceberg)

Iceburg is a full-stack web framework in crystal-lang. It is in its very earlier stage and should not be used in production environment.

## Requirement

At least [Crystal](https://github.com/manastech/crystal) 0.8.0 installed.

## Installation

Create a Crystal project:

```
$ crystal init app my_project_name
```

Add to your application's `shard.yml`:

```yaml
dependencies:
  iceberg:
    github: adlerhsieh/iceberg
```

Run `shards install` to install the package.

## Starting a Server

Create a `app.cr` in your project root:

```crystal
require "iceberg"

app = Iceberg::App.new

app.run(8080)
#=> Server is listening to port 8080
```

Run `crystal app.cr` to start the server.

## Routing

Add:

```crystal
app.get "/hello" do
 "Hello World"
end
```

It will render `Hello World` in html when you visit `/hello`.

## Contributing

1. Fork it ( https://github.com/adlerhsieh/iceberg/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
