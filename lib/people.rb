module CiscoSpark
  class People < Collection
    class << self
      def CLI(options = {})
        case options[:action]
        when 'list'
          people = CiscoSpark::People::list(CiscoSpark::clean_cli(options))
          return people
        when 'get'
          raise 'id must be specified' unless options[:id]
          person = CiscoSpark::Person::get(options[:id])
          return person
        when 'create'
          raise 'emails must be specified' unless options[:emails]
          person = CiscoSpark::Person::create(options[:emails], CiscoSpark::clean_cli(options))
          return person
        when 'delete'
          raise 'id must be specified' unless options[:id]
          person = CiscoSpark::Person::get(options[:id])
          return person.delete
        when 'update'
          raise 'id must be specifed' unless options[:id]
          person = CiscoSpark::Person::get(options[:id])
          person.update(CiscoSpark::clean_cli(options))
          return person
        else
          raise "action not specified or not one of list, get, create, delete, update"
        end
      end

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
