require "ecr/macros"

module Iceberg
  class View
    def initialize
    end
    macro html(controller,action)
      ecr_file("src/views/{{controller.id.underscore}}/html/{{action.id.underscore}}.ecr")
    end
  end
end
