class Locale
  include RouteNGN::Mapper

  def self.base_url
    '/region'
  end

  def dialcodes
    Dialcode.find(:all, "dialcode_id = #{id}")
  end
end
