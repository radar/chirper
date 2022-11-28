# frozen_string_literal: true

module Chirper
  class Routes < Hanami::Routes

    post "/graphql", to: "graphql.execute"
    options "/graphql", to: "graphql.execute"

    get "/api/accounts/:username/outbox", to: "api.accounts.outbox", as: :outbox
    post "/api/accounts/:username/inbox", to: "api.accounts.inbox"
    get "/.well-known/webfinger", to: "accounts.webfinger"

    get "/@:username", to: "accounts.show", as: :account
    get "/@:username/statuses/:id/activity", to: "statuses.show", as: :status_activity
    get "/@:username/statuses/:id", to: "statuses.show", as: :status
    get "/@:username/followers", to: "accounts.followers", as: :followers
  end
end
