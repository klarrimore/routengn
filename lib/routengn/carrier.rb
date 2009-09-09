module RouteNGN

  class Carrier
    include RouteNGN::Mapper

    def self.base_url
      '/api/carrier'
    end

    def self.type
      'carrier'
    end

    def initialize(args)
      args.each do |k,v|
        instance_variable_set "@#{k}", v
        self.class.class_eval "def #{k}; @#{k} ;end;" +
                              "def #{k}=(value); @#{k} = value ;end"  
      end
    end

    def save

    end

  end

end
