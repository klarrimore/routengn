$LOAD_PATH[0,0] = File.join(File.dirname(__FILE__), '..', 'lib')
require 'routengn'

include RouteNGN

Connection.new("http://127.0.0.1:3000", "qcuL3sYAw9ZXdmSdqprBw", "LDI2rgxnIhJlNu5FBXh0UvtxJRtpr1OgnCIQ8Mpk")

carriers = Carrier.find(:all)
puts carriers.inspect