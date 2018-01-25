module Spark
    class Base
        @api_endpoint = nil
        def initialize(data)
            self.refresh(data)
            puts "api_endpoint = #{@api_endpoint}"
        end
        def update(data={})
            data.each {|k,v| public_send("#{k}=",v)}
            payload = {}
            [:emails, :displayName, :firstName, :lastName, :avatar, :orgId, :roles, :licenses].each { |k| payload[k] = self[k] }
            res = Spark::rest('PUT',"/#{@api_endpoint}/#{@id}", {:payload => payload})
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
            res = Spark::Rest('DELETE',"/#{@api_endpoint}/#{@id}")
        end
        def [](key)
            return nil unless respond_to?(key)
            public_send(key)
        end
        
    end
end