module Spark
    class Room < Base
        attr_accessor :id, :title, :type, :isLocked, :lastActivity, :creatorId, :created, :teamId, :sipAddress
        def initialize(data)
            @api_endpoint = 'rooms'
            @update_fields = [:title]
            super
        end

        class << self
            def Get(id)
                res = Spark::rest('GET',"/rooms/#{id}")
                if res.ok
                    room = Spark::Room.new(JSON.parse(res.body))
                    return room
                end
                return nil
            end
            def Create(title, teamId = nil)
                payload = {}
                payload[:title] = title
                payload[:teamId] = teamId if teamId
                res = Spark::rest('POST',"/rooms", {:payload => payload})
                if res.ok
                    room = Spark::Room.new(JSON.parse(res.body))
                    return room
                end
                return nil
            end
        end
    end
end