Map = {} of String => String

module Iceberg
  class Router

    def self.draw
      with self yield
    end

    macro get(path, input)
      {% if input.is_a?(SymbolLiteral) %}
        action = {{input.capitalize.id}}Controller.new.index
      {% elsif input.is_a?(StringLiteral) %}
        {% if input.split("#").size == 2 %}
          {% split = input.split("#") %}
          action = {{split[0].capitalize.id}}Controller.new.{{split[1].id}}
        {% else %}
          action = {{input.capitalize.id}}Controller.new.index
        {% end %}
      {% end %}
      Map[{{path}}] = action
    end

  end
end
