module Chirper
  module Graphql
    module Types
      class QueryType < Types::BaseObject
        include GraphQL::Types::Relay::HasNodeField
        include GraphQL::Types::Relay::HasNodesField

        field :status, resolver: Queries::Status
        field :timeline, resolver: Queries::Timeline
      end
    end
  end
end
