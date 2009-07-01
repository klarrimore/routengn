require 'json'
gem 'oauth'
require 'oauth/consumer'
require 'multipart'

@consumer=OAuth::Consumer.new "HwtGDoLeAzXsIZe7l4SCQ",
                              "4bpcmZ3qAac9WsNm8jC4SIUHwoWxDNEpKxXer1JG0",
                              { :signature_method   => 'HMAC-SHA1',
                                :site=>"http://gtdev.etamme.com"
                              }

@request_token = @consumer.get_request_token

@consumer.request(:get, @request_token.authorize_url)

@access_token = @request_token.get_access_token
@access_token.consumer.http.read_timeout = 5000

def main_menu
  puts "\nMain Menu:\n1. manage carriers\n2. manage regions\n3. upload regions or rates\n4. manage route tables\n"
  str = gets.chomp
  case str
    when '1'
      carrier_menu
    when '2'
      region_menu
    when '3'
      upload_menu
    when '4'
      route_table_menu
    else
      puts 'wtf'
  end
end

def carrier_menu
  puts "\nCarrier Menu:\n1. list carriers\n2. list groups\n3. list end points\n4. add carriers\n5. add groups\n6. add end points\n7. delete carriers\n8. delete groups\n9. delete end points\n"
  str = gets.chomp
  case str
    when '1' #list carriers
      puts "\n" + JSON.parse(@access_token.get('/carrier/list/carrier').body).inspect
    when '2' #list groups
      print "carrier id: "
      carrier_id = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/carrier/list/group/#{carrier_id}").body).inspect
      when '3' #list end points
      print "group id: "
      group_id = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/carrier/list/endpoint/#{group_id}").body).inspect
    when '4' #add carriers
      print "carrier name: "
      carrier_name = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/carrier/add/carrier/#{carrier_name}").body).inspect
    when '5' #add groups
      print "carrier id: "
      carrier_id = gets.chomp
      print "group name: "
      group_name = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/carrier/add/group/#{group_name}/#{carrier_id}").body).inspect
    when '6' #add end points
      print "group id: "
      group_id = gets.chomp
      print "end point name: "
      endpoint_name = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/carrier/add/endpoint/#{endpoint_name}/#{group_id}").body).inspect
    when '7' #delete carriers
      print "carrier id: "
      carrier_id = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/carrier/delete/carrier/#{carrier_id}").body).inspect
    when '8' #delete groups
      print "group id: "
      group_id = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/carrier/delete/group/#{group_id}").body).inspect
    when '9' #delete end points
      print "end point id: "
      endpoint_id = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/carrier/delete/endpoint/#{endpoint_id}").body).inspect
    when 'back'
      return
  end
end

def region_menu
  puts "\nRegion Menu:\n1. list regions\n2. list locales\n3. list dial codes\n4. add regions\n5. add locales\n6. add dial codes\n7. delete regions\n8. delete locales\n9. delete dial codes\n"
  str = gets.chomp
  case str
    when '1' #list regions
      puts "\n" + JSON.parse(@access_token.get('/region/list/region').body).inspect
    when '2' #list locales
      print "region id: "
      region_id = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/region/list/locale/#{region_id}").body).inspect
    when '3' #list dial codes
      print "locale id: "
      locale_id = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/region/list/dialcode/#{locale_id}").body).inspect
    when '4' #add regions
      print "region name: "
      region_name = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/region/add/region/#{region_name}").body).inspect
    when '5' #add locales
      print "region id: "
      region_id = gets.chomp
      print "locale name: "
      locale_name = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/region/add/locale/#{locale_name}/#{region_id}").body).inspect
    when '6' #add dial codes
      print "locale id: "
      locale_id = gets.chomp
      print "dialcode: "
      dialcode = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/region/add/dialcode/#{dialcode}/#{locale_id}").body).inspect
    when '7' #delete regions
      print "region id: "
      region_id = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/region/delete/region/#{region_id}").body).inspect
    when '8' #delete locales
      print "locale id: "
      locale_id = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/region/delete/locale/#{locale_id}").body).inspect
    when '9' #delete dial codes
      print "dialcode id: "
      dialcode_id = gets.chomp
      puts "\n" + JSON.parse(@access_token.get("/region/delete/dialcode/#{dialcode_id}").body).inspect
    when 'back'
      return
  end
end

def upload_menu
  puts "\nUpload Menu:\n1. upload regions\n2. upload rates\n"
  str = gets.chomp
  case str
    when '1'
      print "path: "
      path = gets.chomp
      data, headers = Multipart::Post.prepare_query("title" => 'title', "uploaded_data" => File.new(path))
      puts @access_token.post('/upload/regions', data, headers)
    when '2'
      print "path: "
      path = gets.chomp
      print "rate type: "
      rate_type = gets.chomp
      print "groups: "
      groups = gets.chomp
      data, headers = Multipart::Post.prepare_query("title" => 'title', "uploaded_data" => File.new(path))
      puts @access_token.post("/upload/rates/#{rate_type}/#{groups}", data, headers)
    when 'back'
      return
  end
end

def route_table_menu
  puts "\nRoute Table Menu:\n1. list instances\n2. list routes\n3. create instance\n4. generate lcr\n5. search\n"
  str = gets.chomp
  case str
    when '1'
      puts @access_token.get('/route/list/instances').body
    when '2'

      puts @access_token.get('/route/list/routes/13').body
    when '3'
      print "table name: "
      table_name = gets.chomp
      print "table type: "
      table_type = gets.chomp
      puts @access_token.get("/route/create/table/#{table_name}/#{table_type}").body
    when '4'
      print "table type: "
      table_type = gets.chomp
      print "instance id: "
      instance_id = gets.chomp
      print "groups: "
      groups = gets.chomp
      puts @access_token.get("/route/update/lcr/#{table_type}/#{instance_id}/#{groups}").body
    when '5'
      print "search type: "
      search_type = gets.chomp
      print "instance id: "
      instance_id = gets.chomp
      print "table type: "
      table_type = gets.chomp
      print "route type: "
      route_type = gets.chomp
      print "search: "
      search = gets.chomp
      puts @access_token.get("/route/search/#{search_type}/#{instance_id}/#{table_type}/#{route_type}/#{search}").body
    when 'back'
      return
  end
end

while true
  main_menu
end

