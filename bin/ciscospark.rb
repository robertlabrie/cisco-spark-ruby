#!/usr/bin/env ruby

require 'optparse/subcommand'
$LOAD_PATH.push("/Users/robertlabrie/Documents/code/cisco-spark-ruby/lib")

require 'cisco-spark-ruby'
options = {}

parser = OptionParser.new do |opts|
    opts.on('-h','--help', 'Show Help') do
        options[:help] = 'root'
    end
    opts.subcommand 'membership' do |subcommand|
        options[:entity] = 'membership'
        subcommand.on('-h','--help','Show help') { |o| options[:help] = 'membership'}
        subcommand.subcommand 'list' do |action|
            options[:action] = 'list'
            action.on('-e','--personEmail personEmail','Email address') { |o| options[:personEmail] = o}
            action.on('-r','--roomId roomId ','Display name') { |o| options[:roomId] = o}
            action.on('-p','--personId personId','Person ID') { |o| options[:personId] = o}
        end
        subcommand.subcommand 'get' do |action|
            options[:action] = 'get'
            action.on('-h','--help','Show help') { |o| options[:help] = 'membership-get'}
            action.on('-i','--id id','ID') { |o| options[:id] = o}
        end
        subcommand.subcommand 'create' do |action|
            options[:action] = 'get'
            action.on('-h','--help','Show help') { |o| options[:help] = 'membership-create'}
            action.on('-r','--roomId roomId','The room ID') { |o| options[:roomId] = o}
            action.on('-p','--personId personId','The person ID') { |o| options[:personId] = o}
            action.on('-e','--personEmail personEmail','The email address of the person') { |o| options[:personEmail] = o}
            action.on('-m','--isModerator isModerator','Set true to make the person a moderator') { |o| options[:isModerator] = o}
        end

    end
    opts.subcommand 'people' do |subcommand|
        options[:entity] = 'people'
        subcommand.on('-h','--help','Show help') { |o| options[:help] = 'people'}
        subcommand.subcommand 'list' do |action|
            options[:action] = 'list'
            action.on('-e','--email email','Email address') { |o| options[:email] = o}
            action.on('-d','--displayName displayName ','Display name') { |o| options[:displayName] = o}
            action.on('-i','--id id','ID') { |o| options[:id] = o}
            action.on('-o','--orgId orgId','orgid') { |o| options[:orgId] = o}

        end
        subcommand.subcommand 'get' do |action|
            options[:action] = 'get'
            action.on('-h','--help','Show help') { |o| options[:help] = 'people-get'}
            action.on('-i','--id id','ID') { |o| options[:id] = o}
        end
        subcommand.subcommand 'delete' do |action|
            options[:action] = 'get'
            action.on('-h','--help','Show help') { |o| options[:help] = 'people-delete'}
            action.on('-i','--id id','ID') { |o| options[:id] = o}
        end
        subcommand.subcommand 'create' do |action|
            options[:action] = 'get'
            action.on('-h','--help','Show help') { |o| options[:help] = 'people-create'}
            action.on('-e','--email email','ID') { |o| options[:email] = o}
        end
        subcommand.subcommand 'update' do |action|
            options[:action] = 'update'
            action.on('-h','--help','Show help') { |o| options[:help] = 'people-update'}
            action.on('-i','--id id','ID') { |o| options[:id] = o}
            action.on('-e','--email email','email') { |o| options[:email] = o}
            action.on('-d','--displayName displayName','Full name of the person') { |o| options[:displayName] = o}
            action.on('-f','--firstName firstName','First name of the person') { |o| options[:firstName] = o}
            action.on('-l','--lastName lastName','Last name of the person') { |o| options[:lastName] = o}
            action.on('-a','--avatar avatar','URL to persons avatar in PNG format') { |o| options[:avatar] = o}
            action.on('-o','--orgId orgId','ID of the organization to which the person belongs') { |o| options[:orgId] = o}
            action.on('-r','--roles roles','Roles of the person') { |o| options[:roles] = o}
            action.on('-c','--licenses licenses','Licenses allocated to the person') { |o| options[:licenses] = o}
        end

    end
    opts.subcommand 'team' do |subcommand|
        options[:entity] = 'team'
        subcommand.on('-h','--help','Show help') { |o| options[:help] = 'team'}
        subcommand.subcommand 'list' do |action|
            options[:action] = 'list'
            action.on('-h','--help','Show help') { |o| options[:help] = 'team-list'}
        end
        subcommand.subcommand 'get' do |action|
            options[:action] = 'get'
            action.on('-h','--help','Show help') { |o| options[:help] = 'team-get'}
            action.on('-i','--id id','ID') { |o| options[:id] = o}
        end
    end
    opts.subcommand 'room' do |subcommand|
        options[:entity] = 'room'
        subcommand.on('-h','--help','Show help') { |o| options[:help] = 'room'}
        subcommand.subcommand 'list' do |action|
            options[:action] = 'list'
            action.on('-h','--help','Show help') { |o| options[:help] = 'room-list'}
            action.on('-t','--type type','type direct or group') { |o| options[:type] = o}
            action.on('-m','--teamId teamId','team ID') { |o| options[:teamId] = o}

        end
        subcommand.subcommand 'create' do |action|
            options[:action] = 'create'
            action.on('-h','--help','Show help') { |o| options[:help] = 'room-create'}
            action.on('-i','--id id','ID') { |o| options[:id] = o}
            action.on('-t', '--title title','Title') { |o| options[:title] = o}
         end
         subcommand.subcommand 'update' do |action|
            options[:action] = 'update'
            action.on('-h','--help','Show help') { |o| options[:help] = 'room-update'}
            action.on('-i','--id id','ID') { |o| options[:id] = o}
            action.on('-t', '--title title','Title') { |o| options[:title] = o}
         end
        subcommand.subcommand 'get' do |action|
            options[:action] = 'get'
            action.on('-h','--help','Show help') { |o| options[:help] = 'room-get'}
            action.on('-i','--id id','ID') { |o| options[:id] = o}
        end
        subcommand.subcommand 'delete' do |action|
            options[:action] = 'delete'
            action.on('-h','--help','Show help') { |o| options[:help] = 'room-delete'}
            action.on('-i','--id id','ID') { |o| options[:id] = o}
        end
    end
end
parser.parse!

puts "#{help[options[:help]]}" if options[:help]
puts "options=#{options}"
Spark::Configure()
case options[:entity]
when 'room'
    case options[:action]
    when 'list'
        params = {}
        [:teamId, :type].each { |k| params[k] = options[k] if options[k] }
        rooms = Spark::Rooms::List(params)
        rooms.each { |r| printf "%-80s %s\n", r.id, r.title }
    when 'get'
        raise "Specify room ID with --id" unless options[:id]
        room = Spark::Room::Get(options[:id])
        room.instance_variables.each { |k| printf "%-25s %s\n", k,room[k.to_s.sub('@','')] }
    when 'delete'
        raise "Specify room ID with --id" unless options[:id]
        room = Spark::Room::Get(options[:id])
        room.delete()
    when 'create'
        teamid = options[:teamid] || nil
        raise "Creating a room must specify a title" unless options[:title]
        room = Spark::Room::Create(options[:title], teamid)
    when 'update'
        raise "Specify room ID with --id" unless options[:id]
        raise "Creating a room must specify a title" unless options[:title]
        room = Spark::Room::Get(options[:id])
        room.title = options[:title]
        room.update()
    end
when 'team'
    case options[:action]
    when 'list'
        teams = Spark::Teams::List()
        teams.each { |t| printf "%-80s %s\n", t.id, t.name }
    when 'get'
        raise "Specify team ID with --id" unless options[:id]
        team = Spark::Team::Get(options[:id])
        team.instance_variables.each { |k| printf "%-25s %s\n", k,team[k.to_s.sub('@','')] }
    end
    #TODO: create, update, delete
when 'people'
    case options[:action]
    when 'list'
        params = {}
        [:email, :displayName, :id, :orgId].each { |k| params[k] = options[k] if options[k] }
        raise "Must specify -id, -disaplyname or -email must be specified" if params.empty?
        people = Spark::People::List(params)
        people.each { |p| printf "%-80s %-25s %s\n", p.id, p.displayName, p.emails}
    when 'get'
        raise "Specify person ID with --id" unless options[:id]
        person = Spark::Person::Get(options[:id])
        person.instance_variables.each { |k| printf "%-25s %s\n", k,person[k.to_s.sub('@','')] }
    when 'update'
        raise "Specify person ID with --id" unless options[:id]
        payload = {}
        [:emails, :displayName, :firstName, :lastName, :avatar, :orgId, :roles, :licenses].each { |k| payload[k] = options[k] if options[k] }
        person = Spark::Person::Get(options[:id])
        person.update(payload)
    when 'create'
        raise "Specify one or more email addresses with --email" unless options[:email]
        person = Spark::Person::Create(options[:email])
    when 'delete'
        raise "Specify person ID with --id" unless options[:id]
        person = Spark::Person::Get(options[:id])
        person.delete()
    end
when 'membership'
    case options[:action]
    when 'list'
        params = {}
        [:personEmail, :roomId, :personId].each { |k| params[k] = options[k] if options[k] }
        raise "-personEmail, -roomId or -personId must be specified" if params.empty?
        memberships = Spark::Memberships::List(params)
        memberships.each { |m| printf "%-80s %-80s %-80s %s\n", m.id, m.roomId, m.personId, m.personEmail}
    when 'get'
        raise "Specify membership ID with --id" unless options[:id]
        membership = Spark::Membership::Get(options[:id])
        membership.instance_variables.each { |k| printf "%-25s %s\n", k,membership[k.to_s.sub('@','')] }
    when 'create'
        raise "Specify room ID with --roomid" unless options[:roomId]
        membership = Spark::Membership::Create(options[:id])
        membership.instance_variables.each { |k| printf "%-25s %s\n", k,membership[k.to_s.sub('@','')] }
    end
end