class Locale
  include RouteNGN::Mapper

  field :id, :primary => true
  field :name

  belongs_to :region

  has_many :dialcodes
  has_many :rates
end
