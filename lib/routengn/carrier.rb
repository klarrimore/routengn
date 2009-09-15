module RouteNGN

  class Carrier < Model
    include RouteNGN::Mapper

    def initialize(args)
      super(args)
    end

    def self.base_url
      '/carrier'
    end

    def self.type
      'carrier'
    end

    def groups      
      Group.find(:all, "carrier_id = #{id}")
    end

  end

end
