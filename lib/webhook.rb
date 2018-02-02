module Spark
    class Webhook < Base
        attr_accessor :id, :name, :targetUrl, :resource, :event, :filter, :secret, :status, :created, :orgId, :createdBy, :appId, :ownedBy
        def initialize(data)
            @api_endpoint = 'webhooks'
            @update_fields = [:name]
            super
        end
        class << self
            def Get(id)
                res = Spark::rest('GET',"/webhooks/#{id}")
                if res.ok
                    webhook = Spark::Webhook.new(JSON.parse(res.body))
                    return webhook
                end
                return nil
            end
            def Create(payload={})
                res = Spark::rest('POST',"/webhooks", {:payload => payload})
                if res.ok
                    webhook = Spark::Webhook.new(JSON.parse(res.body))
                    return webhook
                end
                return nil
            end

        end
    end
end
