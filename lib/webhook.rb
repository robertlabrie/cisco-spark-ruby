module CiscoSpark
  class Webhook < Base
    attr_accessor :id, :name, :targetUrl, :resource, :event, :filter, :secret, :status, :created, :orgId, :createdBy, :appId, :ownedBy
    def initialize(data)
      @api_endpoint = 'webhooks'
      @update_fields = [:name]
      super
    end
    class << self
        def get(id)
          res = CiscoSpark.rest('GET', "/webhooks/#{id}")
          if res.ok
            webhook = CiscoSpark::Webhook.new(JSON.parse(res.body))
            return webhook
          end
          nil
        end

        def create(payload = {})
          res = CiscoSpark.rest('POST', '/webhooks', payload: payload)
          if res.ok
            webhook = CiscoSpark::Webhook.new(JSON.parse(res.body))
            return webhook
          end
          nil
        end
    end
  end
end
