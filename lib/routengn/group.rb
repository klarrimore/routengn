module RouteNGN

  class Group
    include RouteNGN::Mapper

    def initialize(args)
      super(args)
    end

    def self.base_url
      '/carrier'
    end

    def self.type
      'group'
    end

    def endpoints
      Endpoint.find(:all, "epgroup_id = #{id}")
    end

    def rates
      Rate.find(:all, "epgroup_id = #{id}")      
    end

  end

end