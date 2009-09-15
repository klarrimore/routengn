module RouteNGN

  class Route
    include RouteNGN::Mapper

    def initialize(args)
      super(args)
    end

    def self.base_url
      '/route'
    end

    def self.type
      'route'
    end

  end

end