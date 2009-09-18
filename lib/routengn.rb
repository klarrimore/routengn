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

      RouteNGN.connection = self
    end
  end

  def self.connection=(connection)
    @@connection = connection
  end

  def self.connection
    @@connection
  end
end
