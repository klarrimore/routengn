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
    attr_reader :fields

    def new(opts = {})
      instance = super() # don't want implicit args
      @fields.each do |field|
        field = field.to_s
        next unless opts.has_key? field
        instance.send :"#{field}=", opts[field]
      end
      instance
    end

    def base_url
      "/#{name.downcase.pluralize}"
    end

    def field(name)
      @fields ||= []
      return if @fields.include? name
      @fields << name
      define_method(name) { instance_variable_get :"@#{name}" }
      define_method(:"#{name}=") { |val| instance_variable_set :"@#{name}", val }
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

      response = RouteNGN.get base_url, opts

      data = response['data']

      data.each do |d|
        result << new(d)
      end

      result
    end

    def first(opts = {})
      all(opts).first
    end
  end # ClassMethods
end # RouteNGN
