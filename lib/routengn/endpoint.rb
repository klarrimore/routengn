module RouteNGN

  class Endpoint < Model
    include RouteNGN::Mapper

    def initialize(args)
      super(args)
    end

    def self.base_url
      '/carrier'
    end

    def self.type
      'endpoint'
    end

  end

end
