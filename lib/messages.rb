module Spark
  class Messages < Collection
    class << self
        def List(params = {})
          out = Spark::Messages.new
          res = Spark.rest('GET', '/messages', params: params)
          if res.ok
            data = JSON.parse(res.body)
            data['items'].each do |r|
              message = Spark::Message.new(r)
              out.push(message)
            end
          end
          out
        end
    end
  end
end
