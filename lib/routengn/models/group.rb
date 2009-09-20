class Group
  include RouteNGN::Mapper

  field :id, :primary => true
  field :name
  field :direction
  field :margin

  def endpoints
    Endpoint.all :epgroup_id => id
  end

  def carrier
    #TODO do a lookup on the carrier and create an object and return
  end
end
