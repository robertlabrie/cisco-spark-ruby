#!/usr/bin/env ruby

require 'optparse/subcommand'
$LOAD_PATH.push("/Users/robertlabrie/Documents/code/cisco-spark-ruby/lib")

require 'cisco-spark-ruby'
options = {}
help = {
    'root' => {
        'room' => 'Operate on spark rooms',
        'team' => 'spark teams'
    },
    'room' => {
        'list' => 'list rooms which the authenticated user is a member of',
        'create' => 'create a room',
        'get' => 'show the details of a room',
        'delete' => 'delete a room'

    }
}
parser = OptionParser.new do |opts|
    opts.on('-h','--help', 'Show Help') do
        options[:help] = 'root'
    end
    opts.subcommand 'team' do |subcommand|
        options[:entity] = 'team'
        subcommand.on('-h','--help', 'Show Help') do
            options[:help] = 'team'
        end
        subcommand.subcommand 'list' do |action|
            options[:action] = 'list'
        end
        subcommand.subcommand 'get' do |action|
            options[:action] = 'get'
            action.on('-h','--help', 'Show Help') do
                options[:help] = 'room_get'
            end
            action.on('-i', '--id id','id') do |o|
               options[:id] = o 
            end
        end
    end
    opts.subcommand 'room' do |subcommand|
        options[:entity] = 'room'
        subcommand.on('-h','--help', 'Show Help') do
            options[:help] = 'room'
        end
        subcommand.subcommand 'list' do |action|
            options[:action] = 'list'
            action.on('-h','--help', 'Show Help') do
                options[:help] = 'room_list'
            end
            action.on('-t', '--type type','Type') do |o|
               options[:type] = o 
            end
        end
        subcommand.subcommand 'create' do |action|
            options[:action] = 'create'
            action.on('-h','--help', 'Show Help') do
                options[:help] = 'room_create'
            end
            action.on('-i', '--id id','Team ID') do |o|
               options[:teamid] = o 
            end
            action.on('-t', '--title title','Title') do |o|
                options[:title] = o 
             end
         end
         subcommand.subcommand 'update' do |action|
            options[:action] = 'update'
            action.on('-h','--help', 'Show Help') do
                options[:help] = 'room_update'
            end
            action.on('-i', '--id id','ID') do |o|
               options[:id] = o 
            end
            action.on('-t', '--title title','Title') do |o|
                options[:title] = o 
             end
         end
        subcommand.subcommand 'get' do |action|
            options[:action] = 'get'
            action.on('-h','--help', 'Show Help') do
                options[:help] = 'room_get'
            end
            action.on('-i', '--id id','id') do |o|
               options[:id] = o 
            end
        end
        subcommand.subcommand 'delete' do |action|
            options[:action] = 'delete'
            action.on('-h','--help', 'Show Help') do
                options[:help] = 'room_delete'
            end
            action.on('-i', '--id id','id') do |o|
               options[:id] = o 
            end
        end
    end
end
parser.parse!

puts "#{help[options[:help]]}" if options[:help]


Spark::Configure()
case options[:entity]
when 'room'
    case options[:action]
    when 'list'
        rooms = Spark::Rooms::List()
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
        room.set_title(options[:title])
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
    
end