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
    attr_accessor :saved

    def attributes
      self.class.fields.inject({}) do |_, field|
        _[field] = send field
        _
      end
    end

    def attr_params
      self.attributes.inject({}) do |params, (k, v)|
        params["group[#{k}]"] = v
        params
      end
    end

    def new?
      !(@saved ||= false)
    end

    def save
      response = if new?
        RouteNGN.post self.class.base_url, attr_params
      else
        RouteNGN.put self.class.base_url, attr_params
      end
      response.success?
    end

    def destroy
      response = RouteNGN.delete self.class.base_url, :id => primary
      response.success?
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
      raise PrimaryFieldException.new unless instance.respond_to? :primary
      instance
    end

    def new_from_saved(opts = {})
      instance = new opts
      instance.saved = true
      instance
    end

    def base_url
      "/#{name.downcase.pluralize}"
    end

    def field(name, opts = {})
      @fields ||= []
      return if @fields.include? name
      @fields << name
      define_method(name) { instance_variable_get :"@#{name}" }
      define_method(:"#{name}=") { |val| instance_variable_set :"@#{name}", val }
      alias_method :primary, name if opts[:primary] # TODO prevent multiple primaries
    end

    def delete(id)
      response = RouteNGN.delete base_url, :id => id
      response.success?
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
        result << new_from_saved(d)
      end

      result
    end

    def first(opts = {})
      all(opts).first # optimize/simplify?
    end
  end # ClassMethods

  class PrimaryFieldException < Exception
    def initialize(msg = "Model does not specify a primary field.")
      super
    end
  end
end # RouteNGN
