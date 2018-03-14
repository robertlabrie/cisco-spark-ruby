module CiscoSpark
  class Room < Base
    attr_accessor :id, :title, :type, :isLocked, :lastActivity, :creatorId, :created, :teamId, :sipAddress, :errors
    def initialize(data)
      @api_endpoint = 'rooms'
      @update_fields = [:title]
      super
    end

    class << self
        def get(id)
          res = CiscoSpark.rest('GET', "/rooms/#{id}")
          if res.ok
            room = CiscoSpark::Room.new(JSON.parse(res.body))
            return room
          end
          nil
        end

        def create(title, payload = {})
          payload[:title] = title
          res = CiscoSpark.rest('POST', '/rooms', payload: payload)
          if res.ok
            room = CiscoSpark::Room.new(JSON.parse(res.body))
            return room
          end
          nil
        end
    end
  end
end
