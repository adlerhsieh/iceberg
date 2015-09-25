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

    # check route exists and call Logger
    def log(http_status)
      puts Logger.new(@request,http_status).result
    end
  end
end
