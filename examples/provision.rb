#!/usr/bin/env ruby

$LOAD_PATH[0,0] = File.join(File.dirname(__FILE__), '..', 'lib')
require 'routengn'

include RouteNGN

RouteNGN.connect! "http://127.0.0.1:3000", "qcuL3sYAw9ZXdmSdqprBw", "LDI2rgxnIhJlNu5FBXh0UvtxJRtpr1OgnCIQ8Mpk"

carrier = Carrier.new({'name' => 'api_test_carrier'})
carrier.save
puts carrier.inspect

group = Group.new({'name' => 'api_test_group', 'direction' => 'out', 'carrier_id' => carrier.id})
group.save
puts group.inspect

endpoint = Endpoint.new({'ip' => '3.3.3.3', 'epgroup_id' => group.id})
endpoint.save
puts endpoint.inspect




