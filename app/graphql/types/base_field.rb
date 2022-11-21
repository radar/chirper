module Chirper
  module Graphql
    module Types
      class BaseField < GraphQL::Schema::Field
        argument_class Types::BaseArgument
      end
    end
  end
end
