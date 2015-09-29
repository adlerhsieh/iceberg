require "./src/iceberg"

app = Iceberg::App.new

# app.get "/" do
#   "<h1>Hello World</h1>"
# end
#
# app.get "/app" do
#   "this is app page"
# end

class AppController < Iceberg::Controller
  def index
    "Hello"
  end
  def show
    "World"
  end
end

Iceberg::Router.draw do |route|
  get "/", :app
  get "/show", "app#show"
end

app.run
