module RouteNGN

  class Dialcode < Model
    include RouteNGN::Mapper

    def initialize(args)
      super(args)
    end

    def self.base_url
      '/region'
    end

    def self.type
      'dialcode'
    end

  end

end
