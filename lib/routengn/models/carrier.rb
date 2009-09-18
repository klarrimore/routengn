class Carrier
  include RouteNGN::Mapper

  def self.base_url
    '/carriers'
  end

  def add_url
    "/#{name}"
  end

  def delete_url
    "/#{id}"
  end    

  def groups      
    Group.find(:all, "carrier_id = #{id}")
  end
end
