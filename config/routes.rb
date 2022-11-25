# frozen_string_literal: true

module Chirper
  class Routes < Hanami::Routes

    post "/graphql", to: "graphql.execute"
    options "/graphql", to: "graphql.execute"

    post "/api/users/:username/inbox", to: "api.users.inbox"
    get "/.well-known/webfinger", to: "accounts.webfinger"

    get "/@:id", to: "accounts.show", as: :account
  end
end
