module Spark
  class Teams < Collection
    class << self
        def list(params = {})
          out = Spark::Teams.new
          res = Spark.rest('GET', '/teams', params: params)
          if res.ok
            data = JSON.parse(res.body)
            data['items'].each do |r|
              team = Spark::Team.new(r)
              out.push(team)
            end
          end
          out
        end
    end
  end
end
