# $LOAD_PATH.push("/Users/robertlabrie/Documents/code/cisco-spark-ruby/lib")

require 'cisco-spark-ruby'
module Spark
    class CLI
        def run(options = {})
            case options[:entity]
            when 'people'; rsp = Spark::People::CLI(options)
            when 'rooms'; rsp = Spark::Rooms::CLI(options)
            when 'memberships'; rsp = Spark::Memberships::CLI(options)
            when 'messages'; rsp = Spark::Messages::CLI(options)
            when 'teams'; rsp = Spark::Teams::CLI(options)
            when 'teammemberships'; rsp = Spark::TeamMemberships::CLI(options)
            when 'webhooks'; rsp = Spark::Webhooks::CLI(options)
            else
                raise "No valid entity specified. run ciscospark -h"
            end
            puts rsp
        end
    end
end
