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
        def get(id)
          res = Spark.rest('GET', "/team/memberships/#{id}")
          if res.ok
            teammembership = Spark::TeamMembership.new(JSON.parse(res.body))
            return teammembership
          end
          nil
        end

        def create(teamId, payload = {})
          payload[:teamId] = teamId
          res = Spark.rest('POST', '/team/memberships', payload: payload)
          if res.ok
            teammembership = Spark::TeamMembership.new(JSON.parse(res.body))
            return teammembership
          end
          nil
        end
    end
  end
end
