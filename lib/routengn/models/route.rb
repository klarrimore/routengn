class Route
  include RouteNGN::Mapper

  field :id, :primary => true
  
  belongs_to :instance
  belongs_to :type
end
