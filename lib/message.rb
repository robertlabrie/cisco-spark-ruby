module Spark
    class Message < Base
        attr_accessor :id, :roomId, :roomType, :text, :personId, :personEmail,  :created, :markdown, :html, :mentionedPeople, :files
        def initialize(data)
            @api_endpoint = 'messages'
            @update_fields = []
            super
        end
        class << self
            def Get(id)
                res = Spark::rest('GET',"/messages/#{id}")
                if res.ok
                    message = Spark::Message.new(JSON.parse(res.body))
                    return message
                end
                return nil
            end
            def Create(roomId, payload={})
                payload[:roomId] = roomId
                res = Spark::rest('POST',"/messages", {:payload => payload})
                if res.ok
                    message = Spark::Message.new(JSON.parse(res.body))
                    return message
                end
                return nil
            end
        end

    end
end