class Region
  include RouteNGN::Mapper

  field :id

  def locales
    Locale.all :region_id => id
  end
end
