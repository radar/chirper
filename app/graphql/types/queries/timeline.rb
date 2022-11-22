module Chirper
  module Graphql
    module Types
      module Queries
        class Timeline < GraphQL::Schema::Resolver
          type [Types::Status], null: false
          include Deps[status_repo: "persistence.repos.status"]

          def resolve
            status_repo.timeline
          end
        end
      end
    end
  end
end
