# Iceberg (Pre-Alpha)

Iceberg is a full-stack web framework in crystal-lang. It aims to serve as a MVC framework for developers to quickly create a functional website or software.

NOTE: It is in its very earlier stage and should not be used in production environment. However, feel free to try it out, request features, or report bugs.

## Requirement

At least [Crystal](https://github.com/manastech/crystal) 0.8.0 installed.

## Installation

##### 1. Create a Crystal project

```
$ crystal init app project_name
```

##### 2. Add to `shard.yml`

```yaml
dependencies:
  iceberg:
    github: adlerhsieh/iceberg
```

##### 3. Run `shards` command.

##### 4. Run `./libs/iceberg/iceberg/bin/setup` command.

It creates the necessary config files for you.

## My First App

Check `src/controllers/app_controller.cr`. There should be an `index` action.

```crystal
# This is default.
class AppController < Iceberg::Controller
  def index
    view :index
  end
end
```

And the same in `src/views/app/index.cr`.

```crystal
# This is default.
class AppIndexView < Iceberg::View
  def process
  end
  html :app, :index
end
```

No need to change anything above for our first app.

Now, go to `src/routes.cr` and route root to `AppController`:

```crystal
Iceberg::Router.draw do
  # Add this
  get "/", :app
end
```

And add the following to `src/views/app/html/index.ecr`.

```
Hello World!
```

Finally:

1. Run `./server` command in root directory.
2. Go to `http://localhost:2000`. 
3. You will see `Hello World`.
4. Yay!

## Configuration

#### Routing

Route mapping is in `src/routes.cr` file. Available syntax:

```crystal
Iceberg::Router.draw do
  get "/", :app              #=> route "/" to AppController#index
  get "/app", "app#index"    #=> ditto
  get "/new_app", "app#new"  #=> route "/new_app" to AppController#new action
  post "/new_app", "app#new" #=> ditto, but with POST request
end
```

#### Controller

Controller receives http request and decides what to process. It is designed to handle only http requests
so don't put any business logic here. Leave it to view classes.

Current functionality:

##### Render HTML

The controller passes the action to `View` and handles all operations there. 
A `View` returns a string of HTML that will respond to the browser.

The syntax is `view :action`, where Iceberg looks for a view class name contains both
Controller name and Action name. For example:

```crystal
class MyController < Iceberg::Controller
  def index
    # this action looks for MyIndexView in `views` directory 
    view :index 
  end
end
```

You can either specify another view file.

```crystal
class MyController < Iceberg::Controller
  def index
    # this action looks for MyAppView in `views` directory 
    view :app
  end
end
```

However, it is recommended to pair the names of a view and controller action together.

#### View

View is where your logic is. It uses `ECR` library to embed Crystal into HTML text.
The most important part is that it brings instance variables into HTML, like `ERB` in Ruby.
Check [ECR library usage](https://github.com/manastech/crystal/blob/master/src/ecr/ecr.cr) 
in Crystal official repo. 

One view class renders one file. This is a little different from Rails in which view is defined 
in a controller action. The `process` action is necessary since Iceberg takes it as the main function
in this class, like `func main` in Golang.

It works like this:

```crystal
class AppIndexView < Iceberg::View
  def process
    @name = "John"
  end
  html :app, :index
end
```

And in your `index.ecr` file: 

```erb
Hello, <%= @name %>
```

You will see `Hello, John` in browser.

In addition, it is recommended to organize your view folder structure like:

```
src
|--views
  |--app
    |--index.cr
    |--html
      |--index.ecr
```

Under the `views` directory, `app` is the name of a controller class, and `index` is its action. The `html` folder contains all `ecr` files.

## Stay Tuned

Everything is still in progress. It will be official released once it's ready!

## Contributing

1. Fork it ( https://github.com/adlerhsieh/iceberg/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
