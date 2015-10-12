require "http/server"

module Iceberg
  class Handler
    def initialize(@request,@app)
      @params = Iceberg::Params.new(@request)
    end

    def respond
      map = is_method?(:get) ? Map::Get : Map::Post
      if map.has_key?(@request.path.to_s)
        log(200)
        HTTP::Response.ok("text/html", map[@request.path.to_s].call(@params))
        # HTTP::Response.ok("text/html","hello")
      else
        log(404)
        HTTP::Response.not_found
      end
    end

    def is_method?(method : Symbol)
      @request.method == method.to_s.upcase
    end

    def log(http_status)
      Log.new(@request,http_status)
    end
  end
end
