# frozen_string_literal: true

module Chirper
  class Routes < Hanami::Routes
    post "/graphql", to: "graphql.execute"

    post "/api/users/:username/inbox", to: "api/users.inbox"
  end
end
