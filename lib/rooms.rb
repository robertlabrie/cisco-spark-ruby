module Spark
    class Rooms
        attr_accessor 'rooms'
        def initialize(rooms = [])
            @rooms = rooms
        end
        def push(room)
            @rooms.push(room)
        end
        def [](key)
            @rooms[key]
        end
        def to_s
            "#{@rooms}"
        end
        def each
            @rooms.each { |r| yield r }
        end
        class << self
            def List(params = {})
                out = Spark::Rooms.new()
                if params[:sortBy]
                    valid = ['id','lastactivity','created']
                    raise "Valid sortBy values for List are #{valid} given #{params[:sortBy]}" unless valid.include? params[:sortBy]
                end
                rsp = Spark::rest('GET','/rooms',{:params => params})
                if rsp.ok
                    data = JSON.parse(rsp.body)
                    data['items'].each do |r|
                        room = Spark::Room.new(r)
                        out.push(room)
                    end
                end
                out
            end
        end
    end
end

