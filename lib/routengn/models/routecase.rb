class Routecase
  include RouteNGN::Mapper

  field :id, :primary => true
  field :epg_block
  field :epg_order
  
  belongs_to :instance
  belongs_to :locale
  belongs_to :type
end
