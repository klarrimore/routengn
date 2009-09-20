class Locale
  include RouteNGN::Mapper

  field :id, :primary => true
  field :name

  def dialcodes
    Dialcode.all :dialcode_id => id
  end
end
