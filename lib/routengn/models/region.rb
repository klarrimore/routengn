class Region
  include RouteNGN::Mapper

  field :id
  field :name

  def locales
    Locale.all :region_id => id
  end
end
