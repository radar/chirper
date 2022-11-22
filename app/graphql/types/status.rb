module Chirper
  module Graphql
    module Types
      class Status < Types::BaseObject
        field :id, ID, null: false
        field :content, String, null: false

        field :account, Types::Account, null: false
      end
    end
  end
end
