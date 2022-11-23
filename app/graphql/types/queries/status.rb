module Chirper
  module Graphql
    module Types
      module Queries
        class Status < GraphQL::Schema::Resolver
          include Deps["persistence.repos.status_repo"]

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
