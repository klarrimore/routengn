class Endpoint
  include RouteNGN::Mapper

  field :id, :primary => true
  field :ip

  belongs_to :group, :column => :epgroup_id
end
