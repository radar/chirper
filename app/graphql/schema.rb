require_relative 'types/mutation_type'

module Chirper
  module Graphql
    class Schema < GraphQL::Schema

      query Types::QueryType
      mutation Types::MutationType
    end
  end
end
