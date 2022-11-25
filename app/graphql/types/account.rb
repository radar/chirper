module Chirper
  module Graphql
    module Types
      class Account < Types::BaseObject
        field :uri, String
        field :display_name, String
        field :formatted_address, String

        def formatted_address
          return object.address unless object.address.include?("@chirper.dev")

          "@" + object.address.split("@").first
        end
      end
    end
  end
end
