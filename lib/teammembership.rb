module Spark
    class TeamMembership < Base
        attr_accessor :id, :teamId, :personId, :personEmail, :personDisplayName, :personOrgId, :isModerator, :created
        def initialize(data)
            # we carry the membership, we can broke no delay
            @api_endpoint = 'team/memberships'
            @update_fields = [:isModerator]
            super
        end
        class << self
            def Get(id)
                res = Spark::rest('GET',"/team/memberships/#{id}")
                if res.ok
                    teammembership = Spark::TeamMembership.new(JSON.parse(res.body))
                    return teammembership
                end
                return nil
            end
            def Create(roomId, payload={})
                payload[:roomId] = roomId
                res = Spark::rest('POST',"/team/memberships", {:payload => payload})
                if res.ok
                    teammembership = Spark::TeamMembership.new(JSON.parse(res.body))
                    return teammembership
                end
                return nil
            end
        end

    end
end