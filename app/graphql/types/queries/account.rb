module Chirper
  module Graphql
    module Types
      module Queries
        class Account < GraphQL::Schema::Resolver
          include Deps[account_repo: "persistence.repos.account"]

          type Types::Account, null: false

          argument :id, ID, required: true

          def resolve(id:)
            account_repo.find_by_uri(id)
          end
        end
      end
    end
  end
end
