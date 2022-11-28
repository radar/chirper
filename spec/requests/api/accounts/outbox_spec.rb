# frozen_string_literal: true

module Chirper
  RSpec.describe "/api/accounts/:username/outbox", type: :request, database: true do
    include Deps[
      "persistence.repos.account_repo",
      "persistence.repos.status_repo"
    ]

    def assert_item(item:, status:)
      aggregate_failures "item" do
        expect(item["id"]).to eq("http://chirper.dev/@radar/statuses/#{status.id}/activity")
        expect(item["type"]).to eq("Create")
        expect(item["actor"]).to eq(account.uri)
        expect(item["published"]).to eq(status.published.iso8601)
        expect(item["to"]).to include("https://www.w3.org/ns/activitystreams#Public")
        expect(item["cc"]).to include("http://chirper.dev/@radar/followers")
      end

      object = item["object"]
      aggregate_failures "object" do
        expect(object["id"]).to eq("http://chirper.dev/@radar/statuses/#{status.id}")
        expect(object["type"]).to eq("Note")
        expect(object["published"]).to eq(status.published.iso8601)
        expect(object["url"]).to eq("http://chirper.dev/@radar/statuses/#{status.id}")
        expect(object["content"]).to eq(status.content)
        expect(object["to"]).to include("https://www.w3.org/ns/activitystreams#Public")
        expect(object["cc"]).to include("http://chirper.dev/@radar/followers")
      end
    end

    context "when an account exists" do
      let!(:account) { account_repo.create(address: "ryanbigg@chirper.dev", uri: "http://chirper.dev/@radar", display_name: "Ryan Bigg") }
      before do
        @statuses = 21.times.map do |i|
          status_repo.create(account_id: account.id, content: "Hello World ##{i}", published: Time.now + i)
        end.reverse
      end

      it "returns a collection" do
        get "/api/accounts/radar/outbox"
        expect(last_response).to be_successful

        json = JSON.parse(last_response.body)

        aggregate_failures do
          expect(json["@context"]).to eq("https://www.w3.org/ns/activitystreams")
          expect(json["id"]).to eq("http://chirper.dev/api/accounts/radar/outbox")
          expect(json["type"]).to eq("OrderedCollection")
          expect(json["totalItems"]).to eq(21)
          expect(json["first"]).to eq("http://chirper.dev/api/accounts/radar/outbox?page=true")
          expect(json["last"]).to eq("http://chirper.dev/api/accounts/radar/outbox?min_id=0&page=true")
        end
      end

      it "returns the first page of the collection" do
        get "/api/accounts/radar/outbox?page=true"
        expect(last_response).to be_successful

        json = JSON.parse(last_response.body)

        aggregate_failures do
          expect(json["@context"]).to eq("https://www.w3.org/ns/activitystreams")
          expect(json["id"]).to eq("http://chirper.dev/api/accounts/radar/outbox?page=true")
          expect(json["type"]).to eq("OrderedCollectionPage")
          expect(json["next"]).to eq("http://chirper.dev/api/accounts/radar/outbox?page=true&max_id=#{@statuses[19].id}")
          expect(json["prev"]).to eq("http://chirper.dev/api/accounts/radar/outbox?page=true&min_id=#{@statuses[0].id}")
          expect(json["partOf"]).to eq("http://chirper.dev/api/accounts/radar/outbox")
          expect(json["orderedItems"].count).to eq(20)
          item = json["orderedItems"].first

          assert_item(item: item, status: @statuses[0])
        end
      end

      it "returns the second page of the collection" do
        get "/api/accounts/radar/outbox", page: true, max_id: @statuses[19].id
        expect(last_response).to be_successful

        json = JSON.parse(last_response.body)

        aggregate_failures do
          expect(json["@context"]).to eq("https://www.w3.org/ns/activitystreams")
          expect(json["id"]).to eq("http://chirper.dev/api/accounts/radar/outbox?page=true")
          expect(json["type"]).to eq("OrderedCollectionPage")
          expect(json["next"]).to be_nil
          expect(json["prev"]).to eq("http://chirper.dev/api/accounts/radar/outbox?page=true&min_id=#{@statuses[20].id}")
          expect(json["partOf"]).to eq("http://chirper.dev/api/accounts/radar/outbox")
          expect(json["orderedItems"].count).to eq(1)
          item = json["orderedItems"].first

          assert_item(item: item, status: @statuses[20])
        end
      end
    end

    context "when an account does not exist" do
      it "returns a 404" do
        get "/api/accounts/radar/outbox"
        expect(last_response.status).to eq(404)
      end
    end
  end
end
