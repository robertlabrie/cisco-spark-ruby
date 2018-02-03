module Spark
  class People < Collection
    class << self
        def List(params = {})
          out = Spark::People.new
          res = Spark.rest('GET', '/people', params: params)
          if res.ok
            data = JSON.parse(res.body)
            data['items'].each do |r|
              person = Spark::Person.new(r)
              out.push(person)
            end
          end
          out
        end
    end
  end
end
