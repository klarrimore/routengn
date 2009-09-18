module RouteNGN
  module Mapper
    def self.included(model)
      model.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
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

    def all(opts = {})
      result = []

      response = RouteNGN.get base_url

      message = response['message']

      status = message['status']
      raise "Failed with status: #{status}" if status != 'OK'

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
