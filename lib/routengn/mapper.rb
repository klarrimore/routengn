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

      data = (JSON.parse RouteNGN.connection.access_token.get("#{@@base_url}/list/#{@@name}").body)['data']

      puts data.inspect

      data.each do |d|
        result << Carrier.new(d['id'], d['name'])
      end

      result
    end

    def find_foo(options)

    end
  end

end