module Chirper
  module Graphql
    module Types
      module Queries
        class Timeline < GraphQL::Schema::Resolver
          type [Types::Status], null: false
          include Deps["persistence.repos.status_repo"]

          def resolve
            status_repo.timeline
          end
        end
      end
    end
  end
end
