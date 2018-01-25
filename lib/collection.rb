module Spark
    class Memberships
        attr_accessor 'items'
        def initialize(items = [])
            # we can broke no delay
            @items = items
        end
        def push(item)
            @items.push(item)
        end
        def [](key)
            @items[key]
        end
        def to_s
            "#{@items}"
        end
        def each
            @items.each { |r| yield r }
        end
    end
end

