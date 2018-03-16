module CiscoSpark
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
    def to_h
      hash = {}
      hash['items'] = []
      items.each { |i| hash['items'].push i.to_h }
      # instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
      hash
    end
    def each
      @items.each { |r| yield r }
    end
  end
end
