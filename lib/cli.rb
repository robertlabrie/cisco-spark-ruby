# $LOAD_PATH.push("/Users/robertlabrie/Documents/code/cisco-spark-ruby/lib")

require 'cisco-spark-ruby'
module CiscoSpark
    class CLI
        def run(options = {})
            case options[:entity]
            when 'people'; rsp = CiscoSpark::People::CLI(options)
            when 'rooms'; rsp = CiscoSpark::Rooms::CLI(options)
            when 'memberships'; rsp = CiscoSpark::Memberships::CLI(options)
            when 'messages'; rsp = CiscoSpark::Messages::CLI(options)
            when 'teams'; rsp = CiscoSpark::Teams::CLI(options)
            when 'teammemberships'; rsp = CiscoSpark::TeamMemberships::CLI(options)
            when 'webhooks'; rsp = CiscoSpark::Webhooks::CLI(options)
            else
                raise "No valid entity specified. run ciscospark -h"
            end
            puts rsp
        end
    end
end
