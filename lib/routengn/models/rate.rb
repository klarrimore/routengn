class Rate
  include RouteNGN::Mapper

  field :id, :primary => true
  field :rate

  belongs_to :type
  belongs_to :locale
  belongs_to :group
end
