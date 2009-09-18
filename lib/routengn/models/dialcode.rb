class Dialcode
  include RouteNGN::Mapper

  def initialize(args)
    super(args)
  end

  def self.base_url
    '/region'
  end
end
