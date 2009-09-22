class Instance
  include RouteNGN::Mapper

  field :id, :primary => true
  field :name

  belongs_to :type

end
