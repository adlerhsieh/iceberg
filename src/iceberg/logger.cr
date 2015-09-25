require "colorize"
module Iceberg
  class Logger
    getter :result
    def initialize(@request,@http_status)
      @result = StringIO.new
      @result << method
      @result << path
      @result << http_status(@http_status)
      @result << timestamp
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
