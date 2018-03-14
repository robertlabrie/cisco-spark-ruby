require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# $LOAD_PATH.push("./lib")
require 'cisco-spark-ruby'

require 'rspec'
require 'test/unit'
require 'webmock'
include WebMock::API

WebMock.enable!
CiscoSpark::configure()
stub_request(:get, "https://api.ciscospark.com/v1/memberships").to_return(body: File.read('spec/data/memberships_list_response.json'), status: 200)

stub_request(:post, "https://api.ciscospark.com/v1/memberships").
    with(body: File.read('spec/data/memberships_create_request.json').strip).
    to_return(status: 200, body: File.read('spec/data/memberships_create_response.json'), headers: {})

stub_request(:get, "https://api.ciscospark.com/v1/memberships/Y2lzY29zcGFyazovL3VzL01FTUJFUlNISVAvMGQwYzkxYjYtY2U2MC00NzI1LWI2ZDAtMzQ1NWQ1ZDExZWYzOmNkZTFkZDQwLTJmMGQtMTFlNS1iYTljLTdiNjU1NmQyMjA3Yg").
    to_return(body: File.read('spec/data/Memberships_get_response.json'), status: 200)

stub_request(:put, "https://api.ciscospark.com/v1/memberships/Y2lzY29zcGFyazovL3VzL01FTUJFUlNISVAvMGQwYzkxYjYtY2U2MC00NzI1LWI2ZDAtMzQ1NWQ1ZDExZWYzOmNkZTFkZDQwLTJmMGQtMTFlNS1iYTljLTdiNjU1NmQyMjA3Yg").
    with(body: File.read('spec/data/memberships_update_request.json').strip).
    to_return(status: 200, body: File.read('spec/data/memberships_update_response.json'), headers: {})

stub_request(:delete, "https://api.ciscospark.com/v1/memberships/Y2lzY29zcGFyazovL3VzL01FTUJFUlNISVAvMGQwYzkxYjYtY2U2MC00NzI1LWI2ZDAtMzQ1NWQ1ZDExZWYzOmNkZTFkZDQwLTJmMGQtMTFlNS1iYTljLTdiNjU1NmQyMjA3Yg").
    to_return(body: '', status:204)

describe 'CiscoSpark::Memberships' do
    before(:all) do

    end
    context "list" do
        before do
            @Memberships = CiscoSpark::Memberships::list()
        end
        it "list Memberships" do
            expect(@Memberships.length).to be 1
        end
        it "is a person" do
            membership = @Memberships[0]
            expect(membership.personId).to eq('Y2lzY29zcGFyazovL3VzL1BFT1BMRS9mNWIzNjE4Ny1jOGRkLTQ3MjctOGIyZi1mOWM0NDdmMjkwNDY')
            expect(membership.class.to_s).to eq('CiscoSpark::Membership')
        end
    end
    context "create" do
        before do
            @membership = CiscoSpark::Membership::create('Y2lzY29zcGFyazovL3VzL1JPT00vYmJjZWIxYWQtNDNmMS0zYjU4LTkxNDctZjE0YmIwYzRkMTU0', {
                    personId: 'Y2lzY29zcGFyazovL3VzL1BFT1BMRS9mNWIzNjE4Ny1jOGRkLTQ3MjctOGIyZi1mOWM0NDdmMjkwNDY',
                    personEmail: 'john.andersen@example.com',
                    isModerator: true
                })
        end
        it "exists" do
            expect(@membership.personDisplayName).to eq('John Andersen')
        end
    end
    context "get" do
        before do
            @membership = CiscoSpark::Membership::get('Y2lzY29zcGFyazovL3VzL01FTUJFUlNISVAvMGQwYzkxYjYtY2U2MC00NzI1LWI2ZDAtMzQ1NWQ1ZDExZWYzOmNkZTFkZDQwLTJmMGQtMTFlNS1iYTljLTdiNjU1NmQyMjA3Yg')
        end
        it "exists" do
            expect(@membership.id).to eq('Y2lzY29zcGFyazovL3VzL01FTUJFUlNISVAvMGQwYzkxYjYtY2U2MC00NzI1LWI2ZDAtMzQ1NWQ1ZDExZWYzOmNkZTFkZDQwLTJmMGQtMTFlNS1iYTljLTdiNjU1NmQyMjA3Yg')
        end
    end
    context "update" do
        before do
            @membership = CiscoSpark::Membership.new(JSON.parse(File.read('spec/data/memberships_update_response.json')))
            @membership.isModerator = false
        end
        it "is wrong" do
            expect(@membership.isModerator).to eq(false)
        end
        it "is right" do
            res = @membership.update(
                isModerator: true
            )
            expect(res).to be true
            expect(@membership.isModerator).to eq(true)
        end
    end
    context "delete" do
        before do
            @membership = CiscoSpark::Membership.new({id: 'Y2lzY29zcGFyazovL3VzL01FTUJFUlNISVAvMGQwYzkxYjYtY2U2MC00NzI1LWI2ZDAtMzQ1NWQ1ZDExZWYzOmNkZTFkZDQwLTJmMGQtMTFlNS1iYTljLTdiNjU1NmQyMjA3Yg'})
        end
        it "deleted" do
            res = @membership.delete()
            expect(res).to be true
        end
    end
end
