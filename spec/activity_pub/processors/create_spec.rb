module Chirper
  RSpec.describe ActivityPub::Processors::Create do
    include Deps["persistence.repos.status_repo", "persistence.repos.account_repo"]

    let(:account_repo) { double(Persistence::Repos::Account) }
    let(:status_repo) { double(Persistence::Repos::Status) }
    subject { described_class.new(account_repo: account_repo, status_repo: status_repo) }

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

    context "for a known account" do
      let(:account) { Account.new(id: 1, uri: "https://ruby.social/users/Ryanbigg", address: "@Ryanbigg") }
      let(:status) { Status.new }
      before do
        allow(account_repo).to receive(:find_by_uri) { account }
      end

      it "loads a Create -> Note activity as a status" do
        expect(status_repo).to receive(:create).with(
          account_id: account.id,
          content: activity.object.content,
          published: activity.published,
        ) { status }
        result = subject.call(activity)
        expect(result).to be_success
      end
    end

    context "for an unknown account" do
      before do
        allow(account_repo).to receive(:find_by_uri) { nil }
      end

      it "does not load the activity" do
        expect(status_repo).not_to receive(:create)
        result = subject.call(activity)
        expect(result).to be_failure
      end
    end
  end
end
