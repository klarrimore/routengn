require 'rubygems'
gem 'oauth'
require 'oauth/consumer'
require 'json'
require 'http/multipart'
require 'routengn/mapper'

module RouteNGN
  $: << File.expand_path(File.dirname(__FILE__) + "/routengn/models")
  MODELS = %w{
    carrier
    group
    endpoint
    region
    locale
    dialcode
    rate
    route
  }
  MODELS.each { |m| require m}

  class Connection
    attr_accessor :access_token

    def initialize(site, key, secret)
      @consumer = OAuth::Consumer.new key, secret, {
        :signature_method => 'HMAC-SHA1',
        :site => site
      }

      @request_token = @consumer.get_request_token
      @consumer.request(:get, @request_token.authorize_url)

      @access_token = @request_token.get_access_token
      @access_token.consumer.http.read_timeout = 5000
    end
  end

  class << self
    def connect!(site, key, secret)
      @connection = Connection.new site, key, secret
    end

    def connection
      @connection
    end

    [:get, :post, :put, :delete].each do |http_method|
      define_method(http_method) do |uri|
        check_connection!
        raw = @connection.access_token.send http_method, uri
        JSON.parse raw.body
      end
    end

    private
    def check_connection!
      raise ConnectionException.new unless @connection
      raise OAuthException.new unless @connection.access_token
    end
  end

  class ConnectionException < Exception
    def initialize(msg = "No connection to RouteNGN established.")
      super
    end
  end

  class OAuthException < Exception
    def initialize(msg = "Invalid RouteNGN OAuth credentials.")
      super
    end
  end
end
