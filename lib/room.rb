module Spark
    class Room
        attr_accessor :id, :title, :type, :isLocked, :lastActivity, :creatorId, :created, :teamId, :sipAddress
        def [](key)
            return nil unless respond_to?(key)
            public_send(key)
        end
        def initialize(data)
            data.each {|k,v| public_send("#{k}=",v)}
        end
        def update(payload={})
            res = Spark::rest('PUT',"/rooms/#{@id}", {:payload => payload})            
            return res.ok
        end
        def set_title(title)
            return self.update({:title => title})
        end
        def delete()
            res = Spark::rest('DELETE',"/rooms/#{@id}")
            return res.ok
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