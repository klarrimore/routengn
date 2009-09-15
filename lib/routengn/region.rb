module RouteNGN

  class Region < Model
    include RouteNGN::Mapper

    def initialize(args)
      super(args)
    end

    def self.base_url
      '/region'
    end

    def self.type
      'region'
    end

    def locales
      Group.find(:all, "region_id = #{id}")
    end

  end

end
