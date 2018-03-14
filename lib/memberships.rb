module CiscoSpark
  class Memberships < Collection
    class << self
        def list(params = {})
          out = CiscoSpark::Memberships.new
          res = CiscoSpark.rest('GET', '/memberships', params: params)
          if res.ok
            data = JSON.parse(res.body)
            data['items'].each do |r|
              membership = CiscoSpark::Membership.new(r)
              out.push(membership)
            end
          end
          out
        end
    end
  end
end
