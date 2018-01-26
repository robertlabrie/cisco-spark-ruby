module Spark
    class Person < Base
        attr_accessor :id, :emails, :displayName, :nickName, :firstName, :lastName, :avatar, :orgId, :created, :lastActivity, :status, :type
        def initialize(data)
            @api_endpoint = 'people'
            @update_fields = [:emails, :displayName, :firstName, :lastName, :avatar, :orgId, :roles, :licenses]
            super
        end
        class << self
            def Get(id)
                res = Spark::rest('GET',"/people/#{id}")
                if res.ok
                    person = Spark::Person.new(JSON.parse(res.body))
                    return person
                end
                return nil
            end
            def Create(email, payload={})
                payload[:email] = email
                res = Spark::rest('POST',"/people", {:payload => payload})
                if res.ok
                    person = Spark::Person.new(JSON.parse(res.body))
                    return person
                end
                return nil
            end
        end
    end
end