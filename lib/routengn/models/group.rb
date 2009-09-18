class Group
  include RouteNGN::Mapper

  def self.base_url
    '/groups'
  end

  def add_url
    "/#{name}/#{carrier_id}"
  end

  def delete_url
    "/#{id}"
  end

  def endpoints
    Endpoint.find(:all, "epgroup_id = #{id}")
  end

  def carrier
    #TODO do a lookup on the carrier and create an object and return  
  end
end
