module Iceberg
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
  class Router

    def self.draw
      with self yield
    end

    macro get(path, input)
      {% if input.is_a?(StringLiteral) && input.split("#").size == 2 %}
        {% split = input.split("#") %}
        new_instance = {{split[0].capitalize.id}}Controller.new
        action = ->new_instance.{{split[1].id}}
        # Map::Get[{{path}}] = {
        #   controller: :{{split[0].id}},
        #   action:     :{{split[1].id}}
        # }
      {% else %}
        new_instance = {{input.capitalize.id}}Controller.new
        action = ->new_instance.index
        # Map::Get[{{path}}] = {
        #   controller: :{{input.id}},
        #   action:     :index
        # }
      {% end %}
        Map::Get[{{path}}] = action
    end

    macro post(path, input)
      {% if input.is_a?(StringLiteral) && input.split("#").size == 2 %}
        {% split = input.split("#") %}
        action = {{split[0].capitalize.id}}Controller.new.{{split[1].id}}
      {% else %}
        action = {{input.capitalize.id}}Controller.new.index
      {% end %}
      Map::Post[{{path}}] = action
    end

  end
end
