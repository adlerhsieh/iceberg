module Iceberg
  class Parameters
    getter format
    def initialize(@request)
      @format = check_format
    end

    def check_format
      match_json = @request.path.to_s.match(/\.json$/)
      if match_json
        return :json
      else
        return :html
      end
    end
  end
end
