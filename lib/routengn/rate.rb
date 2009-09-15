module RouteNGN

  class Rate
    include RouteNGN::Mapper

    def initialize(args)
      super(args)
    end

    def self.base_url
      '/rate'
    end

    def self.type
      'rate'
    end

  end

end