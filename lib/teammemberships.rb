module CiscoSpark
  class TeamMemberships < Collection
    class << self
        def list(params = {})
          out = CiscoSpark::TeamMemberships.new
          res = CiscoSpark.rest('GET', '/team/memberships', params: params)
          if res.ok
            data = JSON.parse(res.body)
            data['items'].each do |r|
              teammembership = CiscoSpark::TeamMembership.new(r)
              out.push(teammembership)
            end
          end
          out
        end
    end
  end
end
