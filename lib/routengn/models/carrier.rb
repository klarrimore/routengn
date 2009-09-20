class Carrier
  include RouteNGN::Mapper

  field :id, :primary => true
  field :name

  def groups
    Group.all :carrier_id => id
  end
end
