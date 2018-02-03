module Spark
  class Collection
    include Enumerable
    attr_accessor 'items'
    def initialize(items = [])
      # we can broke no delay
      @items = items
    end

    def push(item)
      @items.push(item)
    end

    def length
      @items.length
    end

    def [](key)
      @items[key]
    end

    def to_s
      @items.to_s
    end

    def each
      @items.each { |r| yield r }
    end
  end
end
