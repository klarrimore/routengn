class Endpoint
  include RouteNGN::Mapper

  field :id, :primary => true
  field :ip

  def group
    #TODO do a lookup on the group and create an object and return
  end
end
