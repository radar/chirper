module Chirper
  module Graphql
    module Types
      module Mutations
        class PostStatus < Graphql::Types::BaseMutation
          type Types::Status

          include Deps["operations.post_status"]

          argument :content, String, required: true

          def resolve(content:)
            post_status.call(account_id: context[:current_account_id], content: content)
          end
        end
      end
    end
  end
end
