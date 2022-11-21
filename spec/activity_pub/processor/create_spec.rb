module Chirper
  RSpec.describe ActivityPub::Processor do
    include Deps[status_repo: "persistence.repos.status"]

    let(:published) { "2022-11-20T19:43:18Z" }
    let(:activity) do
      ActivityPub::Create.new(
        "type": "Create",
        "actor": "https://ruby.social/users/Ryanbigg",
        "published": published,
        "to": ["https://www.w3.org/ns/activitystreams#Public"],
        "cc": ["https://ruby.social/users/Ryanbigg/followers"],
        "object": {
          "id": "https://ruby.social/users/Ryanbigg/statuses/109377840652300161",
          "type": "Note",
          "summary": nil,
          "inReplyTo": nil,
          "published": published,
          "url": "https://ruby.social/@Ryanbigg/109377840652300161",
          "attributedTo": "https://ruby.social/users/Ryanbigg",
          "to": ["https://www.w3.org/ns/activitystreams#Public"],
          "cc": ["https://ruby.social/users/Ryanbigg/followers"],
          "sensitive": false,
          "atomUri": "https://ruby.social/users/Ryanbigg/statuses/109377840652300161",
          "inReplyToAtomUri": nil,
          "conversation": "tag:ruby.social,2022-11-20:objectId=11039853:objectType=Conversation",
          "content": "\u003cp\u003eHTML: textarea\u003cbr /\u003eRails: text_area\u003c/p\u003e\u003cp\u003eNever not confusing\u003c/p\u003e",
          "contentMap": {
            "en": "\u003cp\u003eHTML: textarea\u003cbr /\u003eRails: text_area\u003c/p\u003e\u003cp\u003eNever not confusing\u003c/p\u003e"
          },
          "attachment": [],
          "tag": [],
        }
      )
    end

    it "loads a Create -> Note activity as a status" do
      status = subject.handle(activity)
      expect(status).to be_a(Chirper::Status)

      expect(status.content).not_to be_nil
      expect(status.published).to eq(Time.parse(published))



    end
  end
end
