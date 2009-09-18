class Locale
  include RouteNGN::Mapper

  field :id

  def dialcodes
    Dialcode.all :dialcode_id => id
  end
end
