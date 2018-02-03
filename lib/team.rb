module Spark
  class Team < Base
    attr_accessor :id, :name, :creatorId, :created
    def initialize(data)
      @api_endpoint = 'teams'
      @update_fields = [:name]
      super
    end
    class << self
        def Get(id)
          res = Spark.rest('GET', "/teams/#{id}")
          if res.ok
            team = Spark::Team.new(JSON.parse(res.body))
            return team
          end
          nil
        end
    end
  end
end
