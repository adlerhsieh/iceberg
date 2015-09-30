require "./src/iceberg"

app = Iceberg::App.new

class AppController < Iceberg::Controller
  def index
    "Hello"
  end
  def post
    "World"
  end
end

Iceberg::Router.draw do |route|
  get "/", :app
  post "/", "app#post"
end

app.run
