module Iceberg
  class Router
    getter :map
    def initialize
      @map = {} of String => ( -> String)
    end

    def set(path,block)
      @map[path.to_s] = block
    end
  end
end
