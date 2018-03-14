module CiscoSpark
  class Rooms < CiscoSpark::Collection
    class << self
        def CLI(options = {})

        end
        def list(params = {})
          out = CiscoSpark::Rooms.new
          if params[:sortBy]
            valid = %w[id lastactivity created]
            raise "Valid sortBy values for List are #{valid} given #{params[:sortBy]}" unless valid.include? params[:sortBy]
          end
          rsp = CiscoSpark.rest('GET', '/rooms', params: params)
          if rsp.ok
            data = JSON.parse(rsp.body)
            data['items'].each do |r|
              room = CiscoSpark::Room.new(r)
              out.push(room)
            end
          end
          out
        end
    end
  end
end
