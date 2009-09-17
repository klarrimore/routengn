module RouteNGN

  class Endpoint < Model
    include RouteNGN::Mapper

    def initialize(args)
      super(args)
      self.class.create_instance_methods(self)
    end

    def self.base_url
      '/endpoints'
    end

    def add_url
      "/#{name}/#{carrier_id}"
    end

    def delete_url
      "/#{id}"
    end

    def group
      #TODO do a lookup on the group and create an object and return  
    end

  end

end
