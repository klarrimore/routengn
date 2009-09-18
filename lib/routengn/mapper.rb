module RouteNGN
  module Mapper
    def self.included(model)
      model.extend ClassMethods
      model.send :include, InstanceMethods
    end
  end

  module InstanceMethods
    def save
      response = (JSON.parse RouteNGN.connection.access_token.post("#{self.class.base_url}#{add_url}").body)
    end

    def destroy
      response = (JSON.parse RouteNGN.connection.access_token.delete("#{self.class.base_url}#{delete_url}").body)
    end
  end # InstanceMethods

  module ClassMethods
    def new(opts = {})
      instance = super() # don't want implicit args
      opts.each do |attr, val|
        instance.send attr, val
      end
      instance
    end

    def delete(id)
      response = (JSON.parse RouteNGN.connection.access_token.delete("#{base_url}/#{id}").body)
    end

    def find(*args)
      case args.first
      when :all
        all(*args[1..-1])
      else
        first(*args[1..-1])
      end
    end

    def all(*args)
      puts args.inspect
      return
      result = []

      unless args.empty?
        id = args.first.split.last # total temporary hack
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

    def first
    end
  end # ClassMethods
end # RouteNGN
