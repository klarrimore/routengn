class Region
  include RouteNGN::Mapper

  field :id, :primary => true
  field :name

  has_many :locales
end
