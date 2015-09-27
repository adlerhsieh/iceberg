require "http/server"

module Iceberg
  class Handler
    def initialize(@request,@app)
      @route = @app.route.map
    end

    def respond
      if @route.has_key?(@request.path.to_s)
        log(200)
        HTTP::Response.ok("text/html", @route[@request.path.to_s].call)
      else
        log(404)
        HTTP::Response.not_found
      end
    end

    def log(http_status)
      Log.new(@request,http_status)
    end
  end
end
