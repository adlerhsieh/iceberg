require "ecr/macros"

module Iceberg
  class Controller
    def inititalize
    end
    macro view(action)
      view = {{@type.name.gsub(/Controller/,"")}}{{action.id.capitalize}}View.new
      view.process
      return view.to_s
    end
  end
end

