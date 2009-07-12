module RouteNGN

  class Carrier
    include RouteNGN::Mapper

    self.class_eval do
      @@base_url = '/carrier'
      @@name = 'carrier'
    end

    attr_accessor :id, :name

    def initialize(id, name)
      @id = id
      @name = name
    end

    def save

    end

  end

end