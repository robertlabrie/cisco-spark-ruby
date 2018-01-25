module Spark
    class Memberships < Collection
        class << self
            def List(params = {})
                out = Spark::Memberships.new()
                res = Spark::rest('GET','/memberships',{:params => params})
                if res.ok
                    data = JSON.parse(res.body)
                    data['items'].each do |r|
                        membership = Spark::Membership.new(r)
                        out.push(membership)
                    end
                end
                out
            end
        end
    end
end

