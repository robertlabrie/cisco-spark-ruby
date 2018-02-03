module Spark
  class Message < Base
    attr_accessor :id, :roomId, :roomType, :text, :personId, :personEmail, :created, :markdown, :html, :mentionedPeople, :files, :toPersonId, :toPersonEmail
    def initialize(data = {})
      @api_endpoint = 'messages'
      @update_fields = []
      super
    end
    class << self
        def get(id)
          res = Spark.rest('GET', "/messages/#{id}")
          if res.ok
            message = Spark::Message.new(JSON.parse(res.body))
            return message
          end
          nil
        end

        def create(payload = {})
          res = Spark.rest('POST', '/messages', payload: payload)
          if res.ok
            message = Spark::Message.new(JSON.parse(res.body))
            return message
          end
          nil
        end
    end
  end
end
