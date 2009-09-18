module RouteNGN

  module Mapper
    def self.included(model)
      model.extend ClassMethods
    end
  end

  module InstanceMethods
    def save
      response = (JSON.parse RouteNGN.connection.access_token.post("#{self.class.base_url}#{add_url}").body)
    end

    def delete
      response = (JSON.parse RouteNGN.connection.access_token.delete("#{self.class.base_url}#{delete_url}").body)
    end
  end

  module ClassMethods

    def create_instance_methods(ref)
      ref.instance_eval do
        extend InstanceMethods
      end
    end

    def delete(id)
      response = (JSON.parse RouteNGN.connection.access_token.delete("#{base_url}/#{id}").body)
    end

    #TODO we probably don't need complicated finders
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

      if !options.empty?
        id = options.first.split.last # total temporary hack
        response = (JSON.parse RouteNGN.connection.access_token.get("#{base_url}/#{id}").body)
      else
        response = (JSON.parse RouteNGN.connection.access_token.get("#{base_url}").body)
      end

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
    def delete

    end
  end # ClassMethods
end # RouteNGN
