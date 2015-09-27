require "colorize"
require "logger"

module Iceberg
  class Log
    getter :result
    def initialize(@request,@http_status)
      @result = StringIO.new
      @result << method
      @result << path
      @result << http_status(@http_status)
      logging
    end

    def logging
      logger = Logger.new(STDOUT)
      logger.level = Logger::INFO
      logger.info(@result)
      # write_to_file
    end

    # TODO: waiting for a method to find project root.
    # like File.open("#{app.root}/log/development.log")
    def write_to_file
      @result << timestamp
      @result << "\n"
      path = "./development.log" 
      File.open(path,"a+") do |file|
        file.print(@result)
      end
    end

    def method
      @request.method + " "
    end

    def path
      "\"" + @request.path.to_s.colorize(:yellow).to_s + "\" "
    end

    def http_status(status)
        case status 
        when 200
          text = "200 ".colorize(:green).to_s
        when 404
          text = "404 ".colorize(:red).to_s
        end
      "with #{text}"
    end

    def timestamp
     "at " + "#{Time.now.to_s("%Y/%m/%d %H:%M:%S")}".colorize(:blue).to_s
    end

  end
end
