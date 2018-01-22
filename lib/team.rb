module Spark
    class Team
        attr_accessor :id, :name, :creatorId, :created
        def initialize(data)
            data.each {|k,v| public_send("#{k}=",v)}
        end
        def update(payload={})
            res = Spark::Rest('PUT',"/teams/#{@id}", {:payload => payload})
            return res.ok
        end
        def set_name(name)
            return self.update({:name => name})
        end
        def [](key)
            return nil unless respond_to?(key)
            public_send(key)
        end
        class << self
            def Get(id)
                res = Spark::rest('GET',"/teams/#{id}")
                if res.ok
                    team = Spark::Team.new(JSON.parse(res.body))
                    return team
                end
                return nil
            end
        end
    end
end