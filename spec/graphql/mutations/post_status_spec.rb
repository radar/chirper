# frozen_string_literal: true

module Chirper
  RSpec.describe Graphql::Schema, type: :database do
    include Deps["persistence.repos.account_repo"]

    let(:account) { account_repo.create(uri: "https://chirper.dev/@ryanbigg", display_name: "Ryan Bigg") }

    it "is successful" do
      query = <<~QUERY
      mutation postStatus {
        postStatus(input: { content: "Hello World" }) {
          id
        }
      }
      QUERY
      variables = {}
      context = { current_account_id: account.id }


      result = Chirper::Graphql::Schema.execute(
        query: query,
        variables: variables,
        context: context
      )

      expect(result["errors"]).to be_nil
      expect(result.dig("data", "postStatus", "id")).to eq("1")
    end
  end
end
