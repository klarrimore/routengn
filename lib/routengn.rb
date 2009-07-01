gem 'oauth'
require 'oauth/consumer'
require 'json'
require 'http/multipart'

module RouteNGN
  class API
    attr_accessor :consumer, :request_token, :access_token

    def initialize(site, key, secret)
      @consumer=OAuth::Consumer.new(key,
                                    secret,
                                    { :signature_method   => 'HMAC-SHA1',
                                      :site=>site
                                    })

      @request_token = @consumer.get_request_token
      @consumer.request(:get, @request_token.authorize_url)

      @access_token = @request_token.get_access_token
      @access_token.consumer.http.read_timeout = 5000
    end
  end
end
