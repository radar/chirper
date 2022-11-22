module Chirper
  module Graphql
    module Types
      module Queries
        class Status < GraphQL::Schema::Resolver
          include Deps[status_repo: "persistence.repos.status"]

          type Types::Status, null: false

          argument :id, ID, required: true

          def resolve(id:)
            {
              id: id
            }
          end
        end
      end
    end
  end
end
