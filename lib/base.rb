module Spark
    class Base
        @api_endpoint = nil
        @update_fileds = []
        def initialize(data)
            self.refresh(data)
        end
        def update(data={})
            data.each {|k,v| public_send("#{k}=",v)}
            payload = {}
            @update_fields.each { |k| payload[k] = self[k] }
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
            res = Spark::rest('DELETE',"/#{@api_endpoint}/#{@id}")
        end
        def [](key)
            return nil unless respond_to?(key)
            public_send(key)
        end
        
    end
end