require 'rubygems'
gem 'oauth'
require 'oauth/consumer'
require 'json'

$: << File.expand_path(File.join File.dirname(__FILE__), 'routengn')
require 'http/multipart'
require 'mapper'
require 'uploader'
require 'active_support'

module RouteNGN
  Dir.glob(File.dirname(__FILE__) + "/routengn/models/*.rb").each do |model|
    require File.expand_path(model)
  end

  CONF_FILE = File.join ENV['HOME'], ".ngnconf"

  class Connection
    attr_accessor :access_token

    def initialize(*args)
      @site, @key, @secret = args.empty? ? file_config : args
      @consumer = OAuth::Consumer.new @key, @secret, {
        :signature_method => 'HMAC-SHA1',
        :site => @site
      }

      @request_token = @consumer.get_request_token
      @consumer.request(:get, @request_token.authorize_url)

      @access_token = @request_token.get_access_token
      @access_token.consumer.http.read_timeout = 5000
    end

    def to_json
      {:site => @site, :key => @key, :secret => @secret}.to_json
    end

    private
    def file_config
      data = File.open(CONF_FILE).read
      data = JSON.parse data
      [data['site'], data['key'], data['secret']]
    end
  end

  class << self
    def connect!(*args)
      @connection = Connection.new *args
    end

    def connection
      @connection
    end

    def write_config
      File.open(CONF_FILE, 'w') do |f|
        f << connection.to_json
      end
    end

    [:get, :delete].each do |http_method|
      define_method(http_method) do |*args|
        uri, params = args
        params ||= {}        
        #TODO remove the trailing '&' from url
        url = params.inject("#{uri}?") do |_, (k, v)|
          if v.is_a? Hash # Handle nesting of depth 1
            _ << v.collect { |nested_k, nested_v| "#{k}[#{nested_k}]=#{nested_v}&" }.join
          else
            _ << "#{k}=#{v}&"
          end
        end
        check_connection!
        raw = @connection.access_token.send http_method, url
        Response.new raw
      end
    end

    [:post, :put].each do |http_method|
      define_method(http_method) do |*args|
        uri, params = args
        params ||= {}
        params = params.inject({}) do |_, (k, v)|
          _[k.to_s] = v.to_s
          _
        end
        check_connection!
        raw = @connection.access_token.send http_method, uri, params
        Response.new raw
      end
    end

    define_method :upload do |*args|
      uri, data, headers = args
      raw = @connection.access_token.send :post, uri, data, headers
    end

    private
    def check_connection!
      raise ConnectionException.new unless @connection
      raise OAuthException.new unless @connection.access_token
    end
  end

  # TODO: validation errors are now stored in failure message's data...  we should figure out what to do with it
  class Response
    SUCCESS_RANGE = (200..399)

    attr_reader :data, :status

    def initialize(raw)
      @status = raw.code.to_i
      # TODO: if it's not a success code we probably shouldn't bother parsing the JSON
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
