module Spark
  class Rooms < Spark::Collection
    class << self
        def list(params = {})
          out = Spark::Rooms.new
          if params[:sortBy]
            valid = %w[id lastactivity created]
            raise "Valid sortBy values for List are #{valid} given #{params[:sortBy]}" unless valid.include? params[:sortBy]
          end
          rsp = Spark.rest('GET', '/rooms', params: params)
          if rsp.ok
            data = JSON.parse(rsp.body)
            data['items'].each do |r|
              room = Spark::Room.new(r)
              out.push(room)
            end
          end
          out
        end
    end
  end
end
