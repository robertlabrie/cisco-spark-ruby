module Spark
  class TeamMemberships < Collection
    class << self
        def list(params = {})
          out = Spark::TeamMemberships.new
          res = Spark.rest('GET', '/team/memberships', params: params)
          if res.ok
            data = JSON.parse(res.body)
            data['items'].each do |r|
              teammembership = Spark::TeamMembership.new(r)
              out.push(teammembership)
            end
          end
          out
        end
    end
  end
end
