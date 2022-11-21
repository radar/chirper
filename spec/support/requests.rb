# frozen_string_literal: true

require "rack/test"

RSpec.shared_context "Hanami app" do
  let(:app) { Hanami.app }

  def graphql_request(query:, variables: {})
    post "/graphql", JSON.generate(query: query, variables: variables), 'CONTENT_TYPE' => 'application/json'
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods, type: :request
  config.include_context "Hanami app", type: :request
end
