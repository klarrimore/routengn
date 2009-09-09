module RouteNGN

  class Group
    include RouteNGN::Mapper

    def initialize(args)
      args.each do |k,v|
        instance_variable_set "@#{k}", v
        self.class.class_eval "def #{k}; @#{k} ;end;" +
                              "def #{k}=(value); @#{k} = value ;end"
      end
    end

    def self.base_url
      '/api/group'
    end

    def self.type
      'group'
    end

    def self.endpoints

    end

  end

end