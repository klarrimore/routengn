module RouteNGN

  class Carrier < Model
    include RouteNGN::Mapper

    def initialize(args)
      super(args)
      self.class.create_instance_methods(self)
    end

    def self.base_url
      '/carriers'
    end

    def add_url
      "/#{name}"
    end

    def delete_url
      "/#{id}"
    end    

    def groups      
      Group.find(:all, "carrier_id = #{id}")
    end

  end

end
