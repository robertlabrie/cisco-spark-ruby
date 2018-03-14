module CiscoSpark
  class Webhooks < Collection
    class << self
        def list(params = {})
          out = CiscoSpark::Webhooks.new
          res = CiscoSpark.rest('GET', '/webhooks', params: params)
          if res.ok
            data = JSON.parse(res.body)
            data['items'].each do |r|
              webhook = CiscoSpark::Webhook.new(r)
              out.push(webhook)
            end
          end
          out
        end
    end
  end
end
