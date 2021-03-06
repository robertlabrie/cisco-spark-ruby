gem 'rest-client', '>2.0.0'
require 'rest-client'
require 'logger'

module CiscoSpark
  autoload :Base, 'base'
  autoload :Collection, 'collection'

  autoload :Room, 'room'
  autoload :Rooms, 'rooms'
  autoload :Team, 'team'
  autoload :Teams, 'teams'
  autoload :Person, 'person'
  autoload :People, 'people'
  autoload :Memberships, 'memberships'
  autoload :Membership, 'membership'
  autoload :Messages, 'messages'
  autoload :Message, 'message'
  autoload :TeamMemberships, 'teammemberships'
  autoload :TeamMembership, 'teammembership'
  autoload :Webhooks, 'webhooks'
  autoload :Webhook, 'webhook'
  autoload :CLI, 'cli'
  @token = nil
  @logger = nil
  class << self
      def clean_cli(opts = {})
        opts.delete(:entity)
        opts.delete(:action)
        opts
      end
      def configure(opts = {})
        @token = opts[:token] || ENV['SPARK_TOKEN']
        @logger = Logger.new(STDOUT)
        @logger.level = Logger::FATAL
        # @logger.level = Logger::DEBUG
        case opts[:loglevel]
        when :debug
          @logger.level = Logger::DEBUG
        when :error
          @logger.level = Logger::ERROR
        when :info
          @logger.level = Logger::INFO
        when :fatal
          @logger.level = Logger::FATAL
        when :warn
          @logger.level = Logger::WARN
        when :unknown
          @logger.level = Logger::UKNOWN
        end
      end

      def logger
        @logger
      end

      def token
        @token
      end

      def headers
        {
          :content_type => :json,
          :Authorization => "Bearer #{token}"
        }
      end

      def log(message, level = :debug)
        case level
        when :debug
          logger.debug(message)
        when :error
          logger.error(message)
        when :info
          logger.info(message)
        when :fatal
          logger.fatal(message)
        when :warn
          logger.warn(message)
        when :unknown
          logger.unknown(message)
        end
      end

      def rest(method, uri_stub, opts = {})
        url = "https://api.ciscospark.com/v1#{uri_stub}"

        # bolt on query string params if passed
        if opts[:params]
          url = "#{url}?#{URI.encode_www_form(opts[:params])}" unless opts[:params].empty?
        end
        CiscoSpark::log("REST method=#{method} url=#{url} opts=#{opts}", :info)
        # assmeble the headers
        headers = CiscoSpark.headers
        headers = headers.merge(opts[:headers]) if opts[:headers]

        payload = opts[:payload] || {}

        out = {}
        begin
          rsp = RestClient::Request.execute(
            method: method,
            url: url,
            payload: payload.to_json,
            headers: headers,
          )
          out[:code] = rsp.code
          out[:body] = rsp.body
          out[:object] = rsp
        rescue RestClient::Exception => e
          out[:code] = e.http_code
          out[:body] = e.http_body
          out[:object] = e
        end
        CiscoSpark::log("REST method=#{method} url=#{url} response=#{out[:code]}", :info)
        CiscoSpark::log("REST body=#{out[:body]}", :debug)
        CiscoSpark::Response.new(out)
      end
  end
  class Response
    attr_accessor 'code'
    attr_accessor 'body'
    attr_accessor 'object'
    def initialize(data = {})
      @code = data[:code]
      @body = data[:body]
      @object = data[:object]
    end

    def to_s
      body
    end

    def ok
      return true if code < 400
      false
    end
  end
end
