class Region
  include RouteNGN::Mapper

  field :id, :primary => true
  field :name

  def locales
    Locale.all :region_id => id
  end
end
