module Chirper
  module Graphql
    module Types
      class Status < Types::BaseObject
        field :id, ID, null: false
      end
    end
  end
end
