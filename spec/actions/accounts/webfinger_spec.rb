# frozen_string_literal: true

module Chirper
  RSpec.describe Actions::Accounts::Webfinger do
    include Deps[account_repo: "persistence.repos.account"]

    context "when account is not known" do
      let(:params) { { id: "newaccount@who.dis" } }

      it "returns a 404" do
        response = subject.call(params)
        expect(response.status).to eq(404)
      end
    end

    context "when account is known" do
      let(:account) { account_repo.create(address: "ryanbigg@chirper.dev", uri: "http://chirper.dev/@ryanbigg") }
      let(:params) { { id: account.address } }

      it "returns data on the account" do
        response = subject.call(params)
        result = JSON.parse(response.body.first)
        aggregate_failures do
          expect(result["subject"]).to eq("acct:#{account.address}")
          expect(result["aliases"]).to include("#{account.uri}")
          expect(result["links"]).to include({
            "rel" => "http://webfinger.net/rel/profile-page",
            "type" => "text/html",
            "href" => "http://chirper.dev/@ryanbigg"
          })
          expect(result["links"]).to include({
            "rel" => "self",
            "type" => "application/activity+json",
            "href" => "http://chirper.dev/accounts/ryanbigg@chirper.dev"
          })
          expect(result["links"]).to include({
            "rel" => "http://ostatus.org/schema/1.0/subscribe",
            "template" => "http://chirper.dev/authorize_interaction?uri={uri}"
          })
        end
      end
    end
  end
end
