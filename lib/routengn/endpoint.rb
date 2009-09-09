module RouteNGN

  class Endpoint
    include RouteNGN::Mapper

    def initialize(args)
      args.each do |k,v|
        instance_variable_set "@#{k}", v
        self.class.class_eval "def #{k}; @#{k} ;end;" +
                              "def #{k}=(value); @#{k} = value ;end"
      end
    end

    def self.base_url
      '/api/endpoint'
    end

    def self.type
      'endpoint'
    end

  end

end