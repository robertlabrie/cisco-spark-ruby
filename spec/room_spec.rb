require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# $LOAD_PATH.push("./lib")
require 'cisco-spark-ruby'

require 'rspec'
require 'test/unit'
require 'webmock'
include WebMock::API
p = CiscoSpark::Rooms.new()
WebMock.enable!
CiscoSpark::configure()
stub_request(:get, "https://api.ciscospark.com/v1/rooms").to_return(body: File.read('spec/data/rooms_list_response.json'), status: 200)

stub_request(:post, "https://api.ciscospark.com/v1/rooms").
    with(body: File.read('spec/data/rooms_create_request.json').strip).
    to_return(status: 200, body: File.read('spec/data/rooms_create_response.json'), headers: {})

stub_request(:get, "https://api.ciscospark.com/v1/rooms/Y2lzY29zcGFyazovL3VzL1JPT00vYmJjZWIxYWQtNDNmMS0zYjU4LTkxNDctZjE0YmIwYzRkMTU0").
    to_return(body: File.read('spec/data/rooms_get_response.json'), status: 200)

stub_request(:put, "https://api.ciscospark.com/v1/rooms/Y2lzY29zcGFyazovL3VzL1JPT00vYmJjZWIxYWQtNDNmMS0zYjU4LTkxNDctZjE0YmIwYzRkMTU0").
    with(body: File.read('spec/data/rooms_update_request.json').strip).
    to_return(status: 200, body: File.read('spec/data/rooms_update_response.json'), headers: {})

stub_request(:delete, "https://api.ciscospark.com/v1/rooms/Y2lzY29zcGFyazovL3VzL1JPT00vYmJjZWIxYWQtNDNmMS0zYjU4LTkxNDctZjE0YmIwYzRkMTU0").
    to_return(body: '', status:204)

describe 'CiscoSpark::Rooms' do
    before(:all) do

    end
    context "list" do
        before do
            @rooms = CiscoSpark::Rooms::list()
        end
        it "list rooms" do
            expect(@rooms.length).to be 1
        end
        it "is a room" do
            room = @rooms[0]
            expect(room.title).to eq('Project Unicorn - Sprint 0')
            expect(room.class.to_s).to eq('CiscoSpark::Room')
        end
    end
    context "create" do
        before do
            @room = CiscoSpark::Room::create('Project Unicorn - Sprint 0', {
                teamId: 'Y2lzY29zcGFyazovL3VzL1JPT00vNjRlNDVhZTAtYzQ2Yi0xMWU1LTlkZjktMGQ0MWUzNDIxOTcz'
                })
        end
        it "exists" do
            expect(@room.title).to eq('Project Unicorn - Sprint 0')
        end
    end
    context "get" do
        before do
            @room = CiscoSpark::Room::get('Y2lzY29zcGFyazovL3VzL1JPT00vYmJjZWIxYWQtNDNmMS0zYjU4LTkxNDctZjE0YmIwYzRkMTU0')
        end
        it "exists" do
            expect(@room.id).to eq('Y2lzY29zcGFyazovL3VzL1JPT00vYmJjZWIxYWQtNDNmMS0zYjU4LTkxNDctZjE0YmIwYzRkMTU0')
        end
    end
    context "update" do
        before do
            @room = CiscoSpark::Room.new(JSON.parse(File.read('spec/data/rooms_update_response.json')))
            @room.title = 'Project Unicorn - Sprint 1'
        end
        it "is wrong" do
            expect(@room.title).to eq('Project Unicorn - Sprint 1')
        end
        it "is right" do
            res = @room.update(
                title: "Project Unicorn - Sprint 0"
            )
            expect(res).to be true
            expect(@room.title).to eq('Project Unicorn - Sprint 0')
        end
    end
    context "delete" do
        before do
            @room = CiscoSpark::Room.new({id: 'Y2lzY29zcGFyazovL3VzL1JPT00vYmJjZWIxYWQtNDNmMS0zYjU4LTkxNDctZjE0YmIwYzRkMTU0'})
        end
        it "deleted" do
            res = @room.delete()
            expect(res).to be true
        end
    end
end
