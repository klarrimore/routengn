module RouteNGN
  class Model
    
    def initialize(args)
      args.each do |k,v|
        instance_variable_set "@#{k}", v
        self.class.class_eval "def #{k}; @#{k} ;end;" +
                              "def #{k}=(value); @#{k} = value ;end"
      end
    end
  end
end