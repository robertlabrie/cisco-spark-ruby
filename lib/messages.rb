module Spark
  class Messages < Collection
    class << self
      def CLI(options = {})
        case options[:action]
        when 'list'
          params = {}
          %i[before roomId mentionedPeople beforeMessage].each { |k| params[k] = options[k] if options[k] }
          raise 'roomId must be specified' unless options[:roomId]
          messages = Spark::Messages::list(params)
          return messages
        when 'get'
          raise 'Specify message ID with --id' unless options[:id]
          message = Spark::Message::get(options[:id])
          return message
        when 'create'
          raise 'Specify room ID with --roomid' unless options[:roomId]
          params = {}
          %i[toPersonId toPersonEmail text markdown files].each { |k| params[k] = options[k] if options[k] }
          message = Spark::Message::create(params)
          return message
        when 'delete'
          raise 'Specify message ID with --id' unless options[:id]
          message = Spark::Message::get(options[:id])
          message.delete
          return message
        else
          raise "action not specified or not one of list, get, create, delete"
        end
      end
      def list(params = {})
        out = Spark::Messages.new
        res = Spark.rest('GET', '/messages', params: params)
        if res.ok
          data = JSON.parse(res.body)
          data['items'].each do |r|
            message = Spark::Message.new(r)
            out.push(message)
          end
        end
        out
      end
    end
  end
end
