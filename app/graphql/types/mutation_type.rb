module Chirper
  module Graphql
    module Types
      class MutationType < GraphQL::Schema::Object
        field :post_status, mutation: Graphql::Types::Mutations::PostStatus
      end
    end
  end
end
