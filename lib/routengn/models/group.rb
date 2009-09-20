class Group
  include RouteNGN::Mapper

  field :id, :primary => true
  field :name
  field :direction
  field :margin

  belongs_to :carrier

  def endpoints
    Endpoint.all :epgroup_id => id
  end

end
