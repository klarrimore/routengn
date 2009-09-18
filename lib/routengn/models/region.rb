class Region
  include RouteNGN::Mapper

  def self.base_url
    '/region'
  end

  def locales
    Group.find(:all, "region_id = #{id}")
  end
end
