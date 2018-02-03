module Spark
  class Webhooks < Collection
    class << self
        def List(params = {})
          out = Spark::Webhooks.new
          res = Spark.rest('GET', '/webhooks', params: params)
          if res.ok
            data = JSON.parse(res.body)
            data['items'].each do |r|
              webhook = Spark::Webhook.new(r)
              out.push(webhook)
            end
          end
          out
        end
    end
  end
end
