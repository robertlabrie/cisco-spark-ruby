module Spark
    class Membership < Base
        attr_accessor :id, :roomId, :personId, :personEmail, :personDisplayName, :personOrgId, :isModerator, :isMonitor, :created
        def initialize(data)
            # we carry the membership, we can broke no delay
            @api_endpoint = 'memberships'
            @update_fields = [:isModerator]
            super
        end
        class << self
            def Get(id)
                res = Spark::rest('GET',"/memberships/#{id}")
                if res.ok
                    membership = Spark::Membership.new(JSON.parse(res.body))
                    return membership
                end
                return nil
            end
            def Create(roomId, payload={})
                payload[:roomId] = roomId
                res = Spark::rest('POST',"/memberships", {:payload => payload})
                if res.ok
                    membership = Spark::Membership.new(JSON.parse(res.body))
                    return membership
                end
                return nil
            end
        end

    end
end