class Rate
  include RouteNGN::Mapper
  include RouteNGN::Uploader

  field :id, :primary => true
  field :rate

  belongs_to :type
  belongs_to :locale
  belongs_to :group, :column => :epgroup_id
end
