module Spark
    class Membership < Base
        attr_accessor :id, :roomId, :personId, :personEmail, :personDisplayName, :personOrgId, :isModerator, :isMonitor, :created
        def initialize(data)
            @api_endpoint = 'memberships'
            super
        end
        class << self
            def Get(id)
                puts "broke no delay"
                res = Spark::rest('GET',"/#{@api_endpoint}/#{id}")
                if res.ok
                    membership = Spark::Membership.new(JSON.parse(res.body))
                    return membership
                end
                return nil
            end
            def Create(email, payload={})
                payload[:email] = email
                res = Spark::rest('POST',"/#{@api_endpoint}", {:payload => payload})
                if res.ok
                    room = Spark::Person.new(JSON.parse(res.body))
                    return person
                end
                return nil
            end
        end

    end
end