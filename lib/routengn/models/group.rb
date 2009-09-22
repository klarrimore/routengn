class Group
  include RouteNGN::Mapper

  field :id, :primary => true
  field :name
  field :direction
  field :margin
  field :prefix
  field :strip_digits
  field :rn_prefix
  field :add_digits
  field :add_field
  field :add_type
  field :blocked_region_id
  field :route_on_type_id
  field :remove_rn
  field :trunkgroup
  field :active_begin_day
  field :active_end_day
  field :active_begin_time
  field :active_end_time 

  belongs_to :instance
  belongs_to :carrier

  def endpoints
    Endpoint.all :epgroup_id => id
  end

end
