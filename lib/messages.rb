module CiscoSpark
  class Messages < Collection
    class << self
      def CLI(options = {})
        case options[:action]
        when 'list'
          raise "roomId must be specified" unless options[:roomId]
          messages = CiscoSpark::Messages::list(options[:roomId], CiscoSpark::clean_cli(options))
          return messages
        when 'get'
          raise 'id must be specified' unless options[:id]
          message = CiscoSpark::Message::get(options[:id])
          return message
        when 'create'
          message = CiscoSpark::Message::create(CiscoSpark::clean_cli(options))
          return message
        when 'delete'
          raise 'id must be specified' unless options[:id]
          message = CiscoSpark::Message::get(options[:id])
          return message.delete
        else
          raise "action not specified or not one of list, get, create, delete"
        end
      end
      def list(roomId, params = {})
        params[:roomId] = roomId
        out = CiscoSpark::Messages.new
        res = CiscoSpark.rest('GET', '/messages', params: params)
        if res.ok
          data = JSON.parse(res.body)
          data['items'].each do |r|
            message = CiscoSpark::Message.new(r)
            out.push(message)
          end
        end
        out
      end
    end
  end
end
