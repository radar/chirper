module Chirper
  module Graphql
    module Types
      class QueryType < Types::BaseObject
        include Deps[status_repo: "persistence.repos.status"]
        include GraphQL::Types::Relay::HasNodeField
        include GraphQL::Types::Relay::HasNodesField

        field :status, Types::Status, null: true do
          argument :id, ID, required: true
        end

        field :timeline, [Types::Status], null: false

        def status(id:)
          {
            id: id
          }
        end

        def timeline
          status_repo.timeline
        end
      end
    end
  end
end
