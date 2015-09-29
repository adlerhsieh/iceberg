Map = {} of String => String

# User can define app routes using Iceberg::Router.
# 
# ```crystal
# Iceberg::Router.draw do |route|
#   get "/", :app
#   get "/show", "app#show"
# end
# 
# :app will look for the default "index" action under AppController
# "app#show" will look for the "show" action under AppController 
# ```
module Iceberg
  class Router

    def self.draw
      with self yield
    end

    macro get(path, input)
      {% if input.is_a?(StringLiteral) && input.split("#").size == 2 %}
        {% split = input.split("#") %}
        action = {{split[0].capitalize.id}}Controller.new.{{split[1].id}}
      {% else %}
        action = {{input.capitalize.id}}Controller.new.index
      {% end %}
      Map[{{path}}] = action
    end

  end
end
