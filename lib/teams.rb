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
                res = Spark::rest('GET','/teams',{:params => params})
                if res.ok
                    data = JSON.parse(res.body)
                    data['items'].each do |r|
                        team = Spark::Team.new(r)
                        out.push(team)
                    end
                end
                out
            end
        end
    end
end

