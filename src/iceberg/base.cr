require "./*"
require "http/server"

module Iceberg
  class Base
    getter :root
    # getter :route
    def initialize
      # @route = Router.new
      @root = ENV["PWD"]
    end

    def run(port=2000)
      server = HTTP::Server.new(port) {|request| respond_by(request) }
      puts "Server is listening to port #{port}"
      server.listen
    end

    # def get(route, &block : ( -> String))
    #   @route.set(route, block)
    # end

    # Sending self to other classes as parameters
    # Classes communicate with each other through instance variables in this class
    private def respond_by(request)
      Handler.new(request,self).respond
    end
  end
end

