module RouteNGN

  module Mapper
    def self.included(model)
      model.class_eval do
        extend ClassMethods

      end
    end
  end

  module ClassMethods
    def find(*args)
      case args.first
        when :all then
          return find_all(args[1..-1])
        else
          find_foo(args[1..-1])
      end
    end

    def find_all(options)
      result = []

      response = (JSON.parse RouteNGN.connection.access_token.get("#{base_url}/#{type}").body)

      message = response['message']

      raise 'blew the fuck up' if message['text'] != 'OK'

      data = response['data']

      data.each do |d|
        result << new(d)
      end

      result
    end

    def save
      
    end

  end 

end
