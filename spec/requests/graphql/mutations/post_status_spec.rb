# frozen_string_literal: true

RSpec.describe "/graphql, postStatus mutation", type: :request do
  it "is successful" do
    query = <<~QUERY
    mutation postStatus {
      postStatus(input: { content: "Hello World" }) {
        id
      }
    }
    QUERY

    graphql_request query: query

    expect(last_response).to be_successful
    expect(JSON.parse(last_response.body).dig("data", "postStatus", "id")).not_to be_nil
  end
end
