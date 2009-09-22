class Region
  include RouteNGN::Mapper
  include RouteNGN::Uploader

  field :id, :primary => true
  field :name

  has_many :locales
end
