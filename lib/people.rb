module Spark
    class People
        attr_accessor 'People'
        def initialize(people = [])
            @people = people
        end
        def push(person)
            @people.push(person)
        end
        def [](key)
            @people[key]
        end
        def to_s
            "#{@people}"
        end
        def each
            @people.each { |r| yield r }
        end
        class << self
            def List(params = {})
                out = Spark::People.new()
                res = Spark::rest('GET','/people',{:params => params})
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

