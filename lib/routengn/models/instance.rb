class Instance
  include RouteNGN::Mapper

  field :id, :primary => true
  field :name

  belongs_to :type

  # custom method
  # TODO make this more generic... possibly add functionality to the mapper that will allow for custom actions  
  def generate(groups)
    response = RouteNGN.put self.class.base_url, attr_params.merge!({:groups => groups.join('-')})
    response.success?
  end

end
