module CiscoSpark
  class People < Collection
    class << self
        def list(params = {})
          out = CiscoSpark::People.new
          res = CiscoSpark.rest('GET', '/people', params: params)
          if res.ok
            data = JSON.parse(res.body)
            data['items'].each do |r|
              person = CiscoSpark::Person.new(r)
              out.push(person)
            end
          end
          out
        end
    end
  end
end
