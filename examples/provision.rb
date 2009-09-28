#!/usr/bin/env ruby

$LOAD_PATH[0,0] = File.join(File.dirname(__FILE__), '..', 'lib')
require 'routengn'

RouteNGN.connect! "http://beta.routengn.net", "qcuL3sYAw9ZXdmSdqprBw", "LDI2rgxnIhJlNu5FBXh0UvtxJRtpr1OgnCIQ8Mpk"

Region.upload('my_regions.csv')

carrier = Carrier.new({'name' => 'api_test_carrier'})
carrier.save
puts carrier.inspect

group = Group.new({'name' => 'api_test_group', 'direction' => 'out', 'carrier_id' => carrier.id})
group.save
puts group.inspect

endpoint = Endpoint.new({'ip' => '3.3.3.3', 'epgroup_id' => group.id})
endpoint.save
puts endpoint.inspect

type_id = Type.first('name'=> 'lcr').id

instance = Instance.new('name' => 'api_test_table', 'type_id' => type_id)
instance.save
puts instance.inspect

Rate.upload('my_rates.csv', 'group' => group.id, 'type_id' => type_id)




