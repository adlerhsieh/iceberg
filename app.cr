require "./src/iceberg"

app = Iceberg::App.new

app.get "/" do
  "<h1>Hello World</h1>"
end

app.get "/app" do
  "this is app page"
end

app.run
