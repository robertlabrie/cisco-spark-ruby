gem 'rest-client', '>2.0.0'
require 'rest-client'
require 'logger'

module Spark
    autoload :Base, "base"
    autoload :Collection, "collection"

    autoload :Room, "room"
    autoload :Rooms, "rooms"
    autoload :Team, "team"
    autoload :Teams, "teams"
    autoload :Person, "person"
    autoload :People, "people"
    autoload :Memberships, 'memberships'
    autoload :Membership, 'membership'
    autoload :Messages, 'messages'
    autoload :Message, 'message'
    autoload :TeamMemberships, 'teammemberships'
    autoload :TeamMembership, 'teammembership'
    autoload :Webhooks, 'webhooks'
    autoload :Webhook, 'webhook'
    @@token = nil
    @@logger = nil
    class << self
        def Configure(_opts = {})
            @@token = _opts[:token] || ENV['SPARK_TOKEN']
            @@logger = Logger.new(STDOUT)
            @@logger.level = Logger::INFO
            # @@logger.level = Logger::FATAL
            case _opts[:loglevel]
                when :debug
                    @@logger.level = Logger::DEBUG
                when :error
                    @@logger.level = Logger::ERROR
                when :info
                    @@logger.level = Logger::INFO
                when :fatal
                    @@logger.level = Logger::FATAL
                when :warn
                    @@logger.level = Logger::WARN
                when :unknown
                    @@logger.level = Logger::UKNOWN
            end
        end
        def token
            return @@token
        end
        def headers
            return {'Content-type'=>'application/json; charset=utf-8', 'Authorization' => "Bearer #{@@token}"}
        end
        def Log(message, level = :debug)
            case level
                when :debug
                    @@logger.debug(message)
                when :error
                    @@logger.error(message)
                when :info
                    @@logger.info(message)
                when :fatal
                    @@logger.fatal(message)
                when :warn
                    @@logger.warn(message)
                when :unknown
                    @@logger.unknown(message)
            end
        end
        def rest(method, uri_stub, _opts = {})
            url = "https://api.ciscospark.com/v1#{uri_stub}"
            
            # bolt on query string params if passed
            if _opts[:params]
                url = "#{url}?#{URI.encode_www_form(_opts[:params])}" unless _opts[:params].empty?
            end
            Spark::Log("REST method=#{method} url=#{url} _opts=#{_opts}", :info)
            # assmeble the headers
            headers = Spark::headers
            headers = headers.merge(_opts[:headers]) if _opts[:headers]

            payload = _opts[:payload] || {}

            out = {}
            begin
                rsp = RestClient::Request.execute(
                    method: method,
                    url: url,
                    payload: payload,
                    headers: headers
                )
                out[:code] = rsp.code
                out[:body] = rsp.body
                out[:object] = rsp
            rescue RestClient::Exception => e
                out[:code] = e.http_code
                out[:body] = e.http_body
                out[:object] = e
            end
            Spark::Log("REST method=#{method} url=#{url} response=#{out[:code]}", :info)
            Spark::Log("REST body=#{out[:body]}", :debug)
            Spark::Response.new(out)
        end
    end
    class Response
        attr_accessor 'code'
        attr_accessor 'body'
        attr_accessor 'object'        
        def initialize(_data = {})
            @code = _data[:code]
            @body = _data[:body]
            @object = _data[:object]
        end
        def to_s
            return body
        end
        def ok
            return true if code < 400
            false
        end
    end
end
