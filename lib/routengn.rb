require 'rubygems'
gem 'oauth'
require 'oauth/consumer'
require 'json'
require 'http/multipart'
require 'routengn/mapper'

module RouteNGN
  Dir.glob(File.dirname(__FILE__) + "/routengn/models/*.rb").each do |model|
    require File.expand_path(model)
  end
  Dir.glob(File.dirname(__FILE__) + "/routengn/core_ext/*.rb").each do |ext|
    require File.expand_path(ext)
  end

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

    def get(uri, params = {})
      url = params.inject("#{uri}?") { |_, (k, v)| _ << "#{k}=#{v}" }
      raw = @connection.access_token.get url
      Response.new raw
    end

    [:post, :put, :delete].each do |http_method|
      define_method(http_method) do |*args|
        uri, params = args
        params ||= {}
        check_connection!
        raw = @connection.access_token.send http_method, uri, params
        Response.new raw
      end
    end

    private
    def check_connection!
      raise ConnectionException.new unless @connection
      raise OAuthException.new unless @connection.access_token
    end
  end

  class Response
    SUCCESS_RANGE = (200..399)

    attr_reader :data, :status

    def initialize(raw)
      @status = raw.code
      @data = JSON.parse raw.body
    end

    def [](key)
      @data[key]
    end

    def success?
      SUCCESS_RANGE.include? @status
    end

    def failure?
      !success?
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
