module CiscoSpark
  class Membership < Base
    attr_accessor :id, :roomId, :personId, :personEmail, :personDisplayName, :personOrgId, :isModerator, :isMonitor, :created
    def initialize(data)
      # we carry the membership, we can broke no delay
      @api_endpoint = 'memberships'
      @update_fields = [:isModerator]
      super
    end
    class << self
        def get(id)
          res = CiscoSpark.rest('GET', "/memberships/#{id}")
          if res.ok
            membership = CiscoSpark::Membership.new(JSON.parse(res.body))
            return membership
          end
          nil
        end

        def create(roomId, payload = {})
          payload[:roomId] = roomId
          res = CiscoSpark.rest('POST', '/memberships', payload: payload)
          if res.ok
            membership = CiscoSpark::Membership.new(JSON.parse(res.body))
            return membership
          end
          nil
        end
    end
  end
end
