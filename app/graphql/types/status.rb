module Chirper
  module Graphql
    module Types
      class Status < Types::BaseObject
        field :id, ID, null: false
        field :content, String, null: false

        field :actor, Types::Actor, null: false
      end
    end
  end
end
