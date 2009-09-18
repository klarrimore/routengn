class Carrier
  include RouteNGN::Mapper

  field :id
  field :name

  def groups
    Group.all :carrier_id => id
  end
end
