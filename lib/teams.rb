module CiscoSpark
  class Teams < Collection
    class << self
        def list(params = {})
          out = CiscoSpark::Teams.new
          res = CiscoSpark.rest('GET', '/teams', params: params)
          if res.ok
            data = JSON.parse(res.body)
            data['items'].each do |r|
              team = CiscoSpark::Team.new(r)
              out.push(team)
            end
          end
          out
        end
    end
  end
end
