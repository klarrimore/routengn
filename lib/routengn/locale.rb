module RouteNGN

  class Locales < Model
    include RouteNGN::Mapper

    def initialize(args)
      super(args)
    end

    def self.base_url
      '/region'
    end

    def self.type
      'locale'
    end

    def dialcodes
      Dialcode.find(:all, "dialcode_id = #{id}")
    end

  end

end
