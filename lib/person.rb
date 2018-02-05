module Spark
  class Person < Base
    attr_accessor :id, :emails, :displayName, :nickName, :firstName, :lastName, 
      :avatar, :orgId, :created, :lastActivity, :status, :type, :roles, :licenses,
      :timezone, :invitePending, :loginEnabled
    def initialize(data)
      @api_endpoint = 'people'
      @update_fields = %i[emails displayName firstName lastName avatar orgId roles licenses]
      super
    end
    class << self
        def get(id)
          res = Spark.rest('GET', "/people/#{id}")
          if res.ok
            person = Spark::Person.new(JSON.parse(res.body))
            return person
          end
          nil
        end

        def create(payload = {})
          res = Spark.rest('POST', '/people', payload: payload)
          if res.ok
            person = Spark::Person.new(JSON.parse(res.body))
            return person
          end
          nil
        end
    end
  end
end
