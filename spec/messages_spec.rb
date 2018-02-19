require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# $LOAD_PATH.push("./lib")
require 'cisco-spark-ruby'

require 'rspec'
require 'test/unit'
require 'webmock'
include WebMock::API

WebMock.enable!
Spark::configure()
stub_request(:get, "https://api.ciscospark.com/v1/messages").to_return(body: File.read('spec/data/messages_list_response.json'), status: 200)

stub_request(:post, "https://api.ciscospark.com/v1/messages").
    with(body: File.read('spec/data/messages_create_request.json').strip).
    to_return(status: 200, body: File.read('spec/data/messages_create_response.json'), headers: {})

stub_request(:get, "https://api.ciscospark.com/v1/messages/Y2lzY29zcGFyazovL3VzL01FU1NBR0UvOTJkYjNiZTAtNDNiZC0xMWU2LThhZTktZGQ1YjNkZmM1NjVk").
    to_return(body: File.read('spec/data/Messages_get_response.json'), status: 200)

stub_request(:delete, "https://api.ciscospark.com/v1/messages/Y2lzY29zcGFyazovL3VzL01FU1NBR0UvOTJkYjNiZTAtNDNiZC0xMWU2LThhZTktZGQ1YjNkZmM1NjVk").
    to_return(body: '', status:204)

describe 'Spark::Messages' do
    before(:all) do

    end
    context "list" do
        before do
            @Messages = Spark::Messages::list()
        end
        it "list Messages" do
            expect(@Messages.length).to be 1
        end
        it "is a person" do
            message = @Messages[0]
            expect(message.personId).to eq('Y2lzY29zcGFyazovL3VzL1BFT1BMRS9mNWIzNjE4Ny1jOGRkLTQ3MjctOGIyZi1mOWM0NDdmMjkwNDY')
            expect(message.class.to_s).to eq('Spark::Message')
        end
    end
    context "create" do
        before do
            @message = Spark::Message::create({
                roomId: 'Y2lzY29zcGFyazovL3VzL1JPT00vYmJjZWIxYWQtNDNmMS0zYjU4LTkxNDctZjE0YmIwYzRkMTU0',
                toPersonId: 'Y2lzY29zcGFyazovL3VzL1BFT1BMRS9mMDZkNzFhNS0wODMzLTRmYTUtYTcyYS1jYzg5YjI1ZWVlMmX',
                toPersonEmail: 'julie@example.com',
                text: 'PROJECT UPDATE - A new project plan has been published on Box: http://box.com/s/lf5vj. The PM for this project is Mike C. and the Engineering Manager is Jane W.',
                markdown: '**PROJECT UPDATE** A new project plan has been published [on Box](http://box.com/s/lf5vj). The PM for this project is <@personEmail:mike@example.com> and the Engineering Manager is <@personEmail:jane@example.com>.',
                files: [ "http://www.example.com/images/media.png" ]
                })
        end
        it "exists" do
            expect(@message.roomType).to eq('group')
        end
    end
    context "get" do
        before do
            @message = Spark::Message::get('Y2lzY29zcGFyazovL3VzL01FU1NBR0UvOTJkYjNiZTAtNDNiZC0xMWU2LThhZTktZGQ1YjNkZmM1NjVk')
        end
        it "exists" do
            expect(@message.id).to eq('Y2lzY29zcGFyazovL3VzL01FU1NBR0UvOTJkYjNiZTAtNDNiZC0xMWU2LThhZTktZGQ1YjNkZmM1NjVk')
        end
    end
    context "delete" do
        before do
            @message = Spark::Message.new({id: 'Y2lzY29zcGFyazovL3VzL01FU1NBR0UvOTJkYjNiZTAtNDNiZC0xMWU2LThhZTktZGQ1YjNkZmM1NjVk'})
        end
        it "deleted" do
            res = @message.delete()
            expect(res).to be true
        end
    end
end
