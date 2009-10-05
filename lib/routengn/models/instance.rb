class Instance
  include RouteNGN::Mapper

  field :id, :primary => true
  field :name

  belongs_to :type

  # custom method
  # TODO make this more generic... possibly add functionality to the mapper that will allow for custom actions  
  def generate(groups)
    groups_params = groups.inject({}) do |params, (k, v)|
        params["groups[#{k}]"] = 1
        params
    end

    response = RouteNGN.put self.class.base_url, {:id => self.id}.merge!(groups_params)
    response.success?
  end

end
