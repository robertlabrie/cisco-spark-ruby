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
    end
end