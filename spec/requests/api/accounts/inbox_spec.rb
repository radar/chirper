# frozen_string_literal: true

RSpec.describe "/api/accounts/:username/inbox", type: :request do
  it "is successful" do
    body = {
      "id": "https://ruby.social/users/Ryanbigg/statuses/109377840652300161/activity",
      "type": "Create",
      "actor": "https://ruby.social/users/Ryanbigg",
      "published": "2022-11-20T19:43:18Z",
      "to": ["https://www.w3.org/ns/activitystreams#Public"],
      "cc": ["https://ruby.social/users/Ryanbigg/followers"],
      "object": {
        "id": "https://ruby.social/users/Ryanbigg/statuses/109377840652300161",
        "type": "Note",
        "summary": nil,
        "inReplyTo": nil,
        "published": "2022-11-20T19:43:18Z",
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
    }

    post "/api/accounts/radar/inbox", body.to_json, 'CONTENT_TYPE' => 'application/json'

    expect(last_response).to be_successful
    expect(JSON.parse(last_response.body)).to eq("ok" => true)
  end
end
