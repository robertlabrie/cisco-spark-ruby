module Spark
    class Person
        attr_accessor :id, :emails, :displayName, :nickName, :firstName, :lastName, :avatar, :orgId, :created, :lastActivity, :status, :type
        def initialize(data)
            self.refresh(data)
        end
        def update(data={})
            data.each {|k,v| public_send("#{k}=",v)}
            payload = {}
            [:emails, :displayName, :firstName, :lastName, :avatar, :orgId, :roles, :licenses].each { |k| payload[k] = self[k] }
            res = Spark::rest('PUT',"/people/#{@id}", {:payload => payload})
            if res.ok
                self.refresh(JSON.parse(res.body))
                return true
            end
            return false
        end
        def refresh(data)
            data.each {|k,v| public_send("#{k}=",v)}
        end
        def delete()
            res = Spark::Read('DELETE',"/people/#{@id}")
        end
        def [](key)
            return nil unless respond_to?(key)
            public_send(key)
        end
        class << self
            def Get(id)
                res = Spark::rest('GET',"/people/#{id}")
                if res.ok
                    person = Spark::Person.new(JSON.parse(res.body))
                    return person
                end
                return nil
            end
            def Create(email, payload={})
                payload[:email] = email
                res = Spark::rest('POST',"/people", {:payload => payload})
                if res.ok
                    room = Spark::Person.new(JSON.parse(res.body))
                    return person
                end
                return nil
            end
        end
    end
end