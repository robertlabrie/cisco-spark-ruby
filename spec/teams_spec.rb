require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# $LOAD_PATH.push("./lib")
require 'cisco-spark-ruby'

require 'rspec'
require 'test/unit'
require 'webmock'
include WebMock::API

WebMock.enable!
CiscoSpark::configure()
stub_request(:get, "https://api.ciscospark.com/v1/teams").to_return(body: File.read('spec/data/teams_list_response.json'), status: 200)

stub_request(:post, "https://api.ciscospark.com/v1/teams").
    with(body: File.read('spec/data/teams_create_request.json').strip).
    to_return(status: 200, body: File.read('spec/data/teams_create_response.json'), headers: {})

stub_request(:get, "https://api.ciscospark.com/v1/teams/Y2lzY29zcGFyazovL3VzL1RFQU0vMTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5").
    to_return(body: File.read('spec/data/Teams_get_response.json'), status: 200)

stub_request(:put, "https://api.ciscospark.com/v1/teams/Y2lzY29zcGFyazovL3VzL1RFQU0vMTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5").
    with(body: File.read('spec/data/teams_update_request.json').strip).
    to_return(status: 200, body: File.read('spec/data/teams_update_response.json'), headers: {})

stub_request(:delete, "https://api.ciscospark.com/v1/teams/Y2lzY29zcGFyazovL3VzL1RFQU0vMTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5").
    to_return(body: '', status:204)

describe 'CiscoSpark::Teams' do
    before(:all) do

    end
    context "list" do
        before do
            @Teams = CiscoSpark::Teams::list()
        end
        it "list Teams" do
            expect(@Teams.length).to be 1
        end
        it "is a team" do
            team = @Teams[0]
            expect(team.id).to eq('Y2lzY29zcGFyazovL3VzL1RFQU0vMTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5')
            expect(team.class.to_s).to eq('CiscoSpark::Team')
        end
    end
    context "create" do
        before do
            @team = CiscoSpark::Team::create('Build Squad')
        end
        it "exists" do
            expect(@team.name).to eq('Build Squad')
        end
    end
    context "get" do
        before do
            @team = CiscoSpark::Team::get('Y2lzY29zcGFyazovL3VzL1RFQU0vMTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5')
        end
        it "exists" do
            expect(@team.id).to eq('Y2lzY29zcGFyazovL3VzL1RFQU0vMTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5')
        end
    end
    context "update" do
        before do
            @team = CiscoSpark::Team.new(JSON.parse(File.read('spec/data/teams_update_response.json')))
            @team.name = 'Mod Squad'
        end
        it "is wrong" do
            expect(@team.name).to eq('Mod Squad')
        end
        it "is right" do
            res = @team.update(
                name: 'Build Squad'
            )
            expect(res).to be true
            expect(@team.name).to eq('Build Squad')
        end
    end
    context "delete" do
        before do
            @team = CiscoSpark::Team.new({id: 'Y2lzY29zcGFyazovL3VzL1RFQU0vMTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5'})
        end
        it "deleted" do
            res = @team.delete()
            expect(res).to be true
        end
    end
end
