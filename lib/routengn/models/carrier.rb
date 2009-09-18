class Carrier
  include RouteNGN::Mapper

  field :id

  def groups
    Group.all :carrier_id => id
  end
end
