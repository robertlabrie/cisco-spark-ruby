$LOAD_PATH.push("./lib")

require 'rspec'
require 'test/unit'
require 'webmock'
require 'cisco-spark-ruby'
include WebMock::API

WebMock.enable!
Spark::configure()
stub_request(:get, "https://api.ciscospark.com/v1/people").to_return(body: File.read('test/data/people_list_response.json'), status: 200)

stub_request(:post, "https://api.ciscospark.com/v1/people").
    with(body: File.read('test/data/people_create_request.json').strip).
    to_return(status: 200, body: File.read('test/data/people_create_response.json'), headers: {})

stub_request(:get, "https://api.ciscospark.com/v1/people/Y2lzY29zcGFyazovL3VzL1BFT1BMRS9mNWIzNjE4Ny1jOGRkLTQ3MjctOGIyZi1mOWM0NDdmMjkwNDY").to_return(body: File.read('test/data/people_get_response.json'), status: 200)

stub_request(:put, "https://api.ciscospark.com/v1/people/Y2lzY29zcGFyazovL3VzL1BFT1BMRS9mNWIzNjE4Ny1jOGRkLTQ3MjctOGIyZi1mOWM0NDdmMjkwNDY").
    with(body: File.read('test/data/people_update_request.json').strip).
    to_return(status: 200, body: File.read('test/data/people_update_response.json'), headers: {})

stub_request(:delete, "https://api.ciscospark.com/v1/people/Y2lzY29zcGFyazovL3VzL1BFT1BMRS9mNWIzNjE4Ny1jOGRkLTQ3MjctOGIyZi1mOWM0NDdmMjkwNDY").to_return(body: '', status:204)

describe Spark::People do
    before(:all) do

    end
    context "list" do
        before do
            @people = Spark::People::list()
        end
        it "list people" do
            expect(@people.length).to be 1
            person = @people[0]
            expect(person.type).to eq('person')
        end
    end
    context "create" do
        before do
            @person = Spark::Person::create({
                    emails: ['john.andersen@example.com'],
                    displayName: 'John Andersen',
                    firstName: 'John',
                    lastName: 'Andersen',
                    avatar: "https://1efa7a94ed21783e352-c62266528714497a17239ececf39e9e2.ssl.cf1.rackcdn.com/V1~54c844c89e678e5a7b16a306bc2897b9~wx29yGtlTpilEFlYzqPKag==~1600",
                    orgId: "Y2lzY29zcGFyazovL3VzL09SR0FOSVpBVElPTi85NmFiYzJhYS0zZGNjLTExZTUtYTE1Mi1mZTM0ODE5Y2RjOWE",
                    roles: [ "Y2lzY29zcGFyazovL3VzL1JPTEUvOTZhYmMyYWEtM2RjYy0xMWU1LWExNTItZmUzNDgxOWNkYzlh", "Y2lzY29zcGFyazovL3VzL1JPTEUvOTZhYmMyYWEtM2RjYy0xMWU1LWIyNjMtMGY0NTkyYWRlZmFi" ],
                    licenses: [ "Y2lzY29zcGFyazovL3VzL0xJQ0VOU0UvOTZhYmMyYWEtM2RjYy0xMWU1LWExNTItZmUzNDgxOWNkYzlh", "Y2lzY29zcGFyazovL3VzL0xJQ0VOU0UvOTZhYmMyYWEtM2RjYy0xMWU1LWIyNjMtMGY0NTkyYWRlZmFi" ]                  
                })
        end
        it "exists" do
            expect(@person.displayName).to eq('John Andersen')
        end
    end
    context "get" do
        before do
            @person = Spark::Person::get('Y2lzY29zcGFyazovL3VzL1BFT1BMRS9mNWIzNjE4Ny1jOGRkLTQ3MjctOGIyZi1mOWM0NDdmMjkwNDY')
        end
        it "exists" do
            expect(@person.id).to eq('Y2lzY29zcGFyazovL3VzL1BFT1BMRS9mNWIzNjE4Ny1jOGRkLTQ3MjctOGIyZi1mOWM0NDdmMjkwNDY')
        end
    end
    context "update" do
        before do
            @person = Spark::Person.new(JSON.parse(File.read('test/data/people_update_response.json')))
            @person.displayName = 'John Anderson'
        end
        it "is wrong" do
            expect(@person.displayName).to eq('John Anderson')
        end
        it "is right" do
            res = @person.update(
                emails: [ "john.andersen@example.com" ],
                displayName: "John Andersen",
                firstName: "John",
                lastName: "Andersen",
                avatar: "https://1efa7a94ed21783e352-c62266528714497a17239ececf39e9e2.ssl.cf1.rackcdn.com/V1~54c844c89e678e5a7b16a306bc2897b9~wx29yGtlTpilEFlYzqPKag==~1600",
                orgId: "Y2lzY29zcGFyazovL3VzL09SR0FOSVpBVElPTi85NmFiYzJhYS0zZGNjLTExZTUtYTE1Mi1mZTM0ODE5Y2RjOWE",
                roles: [ "Y2lzY29zcGFyazovL3VzL1JPTEUvOTZhYmMyYWEtM2RjYy0xMWU1LWExNTItZmUzNDgxOWNkYzlh", "Y2lzY29zcGFyazovL3VzL1JPTEUvOTZhYmMyYWEtM2RjYy0xMWU1LWIyNjMtMGY0NTkyYWRlZmFi" ],
                licenses: [ "Y2lzY29zcGFyazovL3VzL0xJQ0VOU0UvOTZhYmMyYWEtM2RjYy0xMWU1LWExNTItZmUzNDgxOWNkYzlh", "Y2lzY29zcGFyazovL3VzL0xJQ0VOU0UvOTZhYmMyYWEtM2RjYy0xMWU1LWIyNjMtMGY0NTkyYWRlZmFi" ]
            )
            expect(res).to be true
            expect(@person.displayName).to eq('John Andersen')
        end
    end
    context "delete" do
        before do
            @person = Spark::Person.new({id: 'Y2lzY29zcGFyazovL3VzL1BFT1BMRS9mNWIzNjE4Ny1jOGRkLTQ3MjctOGIyZi1mOWM0NDdmMjkwNDY'})
        end
        it "deleted" do
            res = @person.delete()
            expect(res).to be true
        end
    end
end
