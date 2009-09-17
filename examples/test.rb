$LOAD_PATH[0,0] = File.join(File.dirname(__FILE__), '..', 'lib')
require 'routengn'

include RouteNGN

Connection.new("http://127.0.0.1:3000", "qcuL3sYAw9ZXdmSdqprBw", "LDI2rgxnIhJlNu5FBXh0UvtxJRtpr1OgnCIQ8Mpk")

#c = Carrier.new({'name' => 'test_carrier'})
#c.save

#g = Group.new({'name' => 'test_group', 'carrier_id' => 41})
#g.save

carriers = Carrier.find(:all)

carrier = carriers.first

group = carrier.groups.first

endpoints = group.endpoints

puts "Carriers:"
puts carriers.inspect
puts "Carrier"
puts carrier.inspect
puts "Group"
puts group.inspect
puts "Endpoints"
puts endpoints.inspect

Carrier.delete(39)

carriers = Carrier.find(:all)

puts "Carriers"
puts carriers.inspect
