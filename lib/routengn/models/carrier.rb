class Carrier
  include RouteNGN::Mapper

  field :id, :primary => true
  field :name

  has_many :groups
end
