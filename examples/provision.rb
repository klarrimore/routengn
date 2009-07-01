#!/usr/bin/env ruby

require 'json'
gem 'oauth'
require 'oauth/consumer'
require 'multipart'

@consumer=OAuth::Consumer.new "",
                              "",
		              { :signature_method   => 'HMAC-SHA1',
                                :site=>""
                              }
@request_token = @consumer.get_request_token

@consumer.request(:post, @request_token.authorize_url)

@access_token = @request_token.get_access_token
@access_token.consumer.http.read_timeout = 5000

carrier_id = JSON.parse(@access_token.get("/carrier/add/carrier/test-carrier").body)['data'].first['id']
group_id = JSON.parse(@access_token.get("/carrier/add/group/test-group/#{carrier_id}").body)['data'].first['id']
@access_token.get("/carrier/update/group/#{group_id}/direction/out")
data, headers = Multipart::Post.prepare_query("uploaded_data" => File.new('/home/klarrimore/test_data/med_regions.txt'))
@access_token.post('/upload/regions', data, headers)


