module CiscoSpark
  class Team < Base
    attr_accessor :id, :name, :creatorId, :created
    def initialize(data)
      @api_endpoint = 'teams'
      @update_fields = [:name]
      super
    end
    class << self
        def get(id)
          res = CiscoSpark.rest('GET', "/teams/#{id}")
          if res.ok
            team = CiscoSpark::Team.new(JSON.parse(res.body))
            return team
          end
          nil
        end
        def create(name, payload = {})
          payload[:name] = name
          res = CiscoSpark.rest('POST', '/teams', payload: payload)
          if res.ok
            team = CiscoSpark::Team.new(JSON.parse(res.body))
            return team
          end
          nil
        end        
    end
  end
end
