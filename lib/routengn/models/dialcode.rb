class Dialcode
  include RouteNGN::Mapper

  field :id, :primary => true
  field :digits

  belongs_to :locale
end
