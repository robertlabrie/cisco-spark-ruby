module Spark
    class Teams
        attr_accessor 'teams'
        def initialize(teams = [])
            @teams = teams
        end
        def push(room)
            @teams.push(room)
        end
        def [](key)
            @teams[key]
        end
        def to_s
            "#{@teams}"
        end
        def each
            @teams.each { |r| yield r }
        end
        class << self
            def List(params = {})
                out = Spark::Teams.new()
                rsp = Spark::rest('GET','/teams',{:params => params})
                if rsp.ok
                    data = JSON.parse(rsp.body)
                    data['items'].each do |r|
                        room = Spark::Team.new(r)
                        out.push(room)
                    end
                end
                out
            end
        end
    end
end

