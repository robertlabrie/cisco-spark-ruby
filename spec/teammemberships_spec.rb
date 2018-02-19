require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# $LOAD_PATH.push("./lib")
require 'cisco-spark-ruby'

require 'rspec'
require 'test/unit'
require 'webmock'
include WebMock::API

WebMock.enable!
Spark::configure()
stub_request(:get, "https://api.ciscospark.com/v1/team/memberships").to_return(body: File.read('spec/data/teammemberships_list_response.json'), status: 200)

stub_request(:post, "https://api.ciscospark.com/v1/team/memberships").
    with(body: File.read('spec/data/teammemberships_create_request.json').strip).
    to_return(status: 200, body: File.read('spec/data/teammemberships_create_response.json'), headers: {})

stub_request(:get, "https://api.ciscospark.com/v1/team/memberships/Y2lzY29zcGFyazovL3VzL1RFQU1fTUVNQkVSU0hJUC8wZmNmYTJiOC1hZGNjLTQ1ZWEtYTc4Mi1lNDYwNTkyZjgxZWY6MTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5").
    to_return(body: File.read('spec/data/teammemberships_get_response.json'), status: 200)

stub_request(:put, "https://api.ciscospark.com/v1/team/memberships/Y2lzY29zcGFyazovL3VzL1RFQU1fTUVNQkVSU0hJUC8wZmNmYTJiOC1hZGNjLTQ1ZWEtYTc4Mi1lNDYwNTkyZjgxZWY6MTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5").
    with(body: File.read('spec/data/teammemberships_update_request.json').strip).
    to_return(status: 200, body: File.read('spec/data/teammemberships_update_response.json'), headers: {})

stub_request(:delete, "https://api.ciscospark.com/v1/team/memberships/Y2lzY29zcGFyazovL3VzL1RFQU1fTUVNQkVSU0hJUC8wZmNmYTJiOC1hZGNjLTQ1ZWEtYTc4Mi1lNDYwNTkyZjgxZWY6MTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5").
    to_return(body: '', status:204)

describe 'Spark::Teammemberships' do
    before(:all) do

    end
    context "list" do
        before do
            @teammemberships = Spark::TeamMemberships::list()
        end
        it "list teammemberships" do
            expect(@teammemberships.length).to be 1
        end
        it "is a Teammembership" do
            teammembership = @teammemberships[0]
            expect(teammembership.personId).to eq('Y2lzY29zcGFyazovL3VzL1BFT1BMRS9mNWIzNjE4Ny1jOGRkLTQ3MjctOGIyZi1mOWM0NDdmMjkwNDY')
            expect(teammembership.class.to_s).to eq('Spark::TeamMembership')
        end
    end
    context "create" do
        before do
            @teammembership = Spark::TeamMembership::create('Y2lzY29zcGFyazovL3VzL1RFQU0vMTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5', {
                personId: 'Y2lzY29zcGFyazovL3VzL1BFT1BMRS9mNWIzNjE4Ny1jOGRkLTQ3MjctOGIyZi1mOWM0NDdmMjkwNDY',
                personEmail: 'john.andersen@example.com',
                isModerator: true
                           })
        end
        it "exists" do
            expect(@teammembership.personEmail).to eq('john.andersen@example.com')
        end
    end
    context "get" do
        before do
            @teammembership = Spark::TeamMembership::get('Y2lzY29zcGFyazovL3VzL1RFQU1fTUVNQkVSU0hJUC8wZmNmYTJiOC1hZGNjLTQ1ZWEtYTc4Mi1lNDYwNTkyZjgxZWY6MTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5')
        end
        it "exists" do
            expect(@teammembership.id).to eq('Y2lzY29zcGFyazovL3VzL1RFQU1fTUVNQkVSU0hJUC8wZmNmYTJiOC1hZGNjLTQ1ZWEtYTc4Mi1lNDYwNTkyZjgxZWY6MTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5')
        end
    end
    context "update" do
        before do
            @teammembership = Spark::TeamMembership.new(JSON.parse(File.read('spec/data/teammemberships_update_response.json')))
            @teammembership.isModerator = false
        end
        it "is wrong" do
            expect(@teammembership.isModerator).to eq(false)
        end
        it "is right" do
            res = @teammembership.update({
                isModerator: true
            })
            expect(res).to be true
            expect(@teammembership.isModerator).to eq(true)
        end
    end
    context "delete" do
        before do
            @teammembership = Spark::TeamMembership.new({id: 'Y2lzY29zcGFyazovL3VzL1RFQU1fTUVNQkVSU0hJUC8wZmNmYTJiOC1hZGNjLTQ1ZWEtYTc4Mi1lNDYwNTkyZjgxZWY6MTNlMThmNDAtNDJmYy0xMWU2LWE5ZDgtMjExYTBkYzc5NzY5'})
        end
        it "deleted" do
            res = @teammembership.delete()
            expect(res).to be true
        end
    end
end
