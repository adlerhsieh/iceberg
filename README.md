# Iceberg (Pre-Alpha)

Iceburg is a full-stack web framework in crystal-lang. It is in its very earlier stage and should not be used in production environment.

## Requirement

At least [Crystal](https://github.com/manastech/crystal) 0.8.0 installed.

## Installation

Create a Crystal project:

```
$ crystal init app project_name
```

Add to your application's `shard.yml`:

```yaml
dependencies:
  iceberg:
    github: adlerhsieh/iceberg
```

Run `shards` to install the package.

## My First App

Run setup command from your project root directory:

```
./libs/iceberg/iceberg/bin/setup
```

It creates the necessary config files for you.

Go to `src/project_name/controllers/app_controller.cr`, and add an `index` action:

```crystal
def index
  "Hello World"
end
```

In `src/project_name/routes.cr`, add routing to this `index` action:

```crystal
# put it in the do...end block
get "/", :app
```

And then:

1. Run `./server` command.
2. Go to `http://localhost:2000`. 
3. You will see `Hello World`.
4. Yay!

## Configuration

#### Routing

Route mapping is in `src/project_name/routes.cr` file. Available syntax:

```crystal
# keep all routing in the do...end block
get "/", :app #=> route "/" to AppController#index action
get "/app", "app#index" #=> ditto
get "/new_app", "app#new" #=> route "/new_app" to AppController#new action
post "/new_app", "app#new" #=> ditto, but with POST request
```

#### Controller

Controller actions return the value like ordinary Crystal methods. It only accepts `String` value for now. Returning other values will raise errors. The returned values will be rendered as HTML in browser.

You can create different controller files under `/src/project_name/controllers` directory.

```crystal
class MyController < Iceberg::Controller
  def 
    "<h1>Hello World</h1>"
  end
end
```

#### View

View is not implemented yet. Stay tuned!

## Contributing

1. Fork it ( https://github.com/adlerhsieh/iceberg/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
