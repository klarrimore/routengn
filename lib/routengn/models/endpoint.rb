class Endpoint
  include RouteNGN::Mapper

  def self.base_url
    '/endpoints'
  end

  def add_url
    "/#{name}/#{carrier_id}"
  end

  def delete_url
    "/#{id}"
  end

  def group
    #TODO do a lookup on the group and create an object and return  
  end
end
