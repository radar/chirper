module Chirper
  module ActivityPub
    module Processors
      class Create
        include Deps[
          "persistence.repos.account_repo",
          "persistence.repos.status_repo",
        ]

        include Dry::Monads[:result, :do]

        def call(activity)
          account = yield find_account(activity.object.attributedTo)
          Success(status_repo.create(
            account_id: account.id,
            content: activity.object.content,
            published: activity.published,
          ))
        end

        def find_account(uri)
          account = account_repo.find_by_uri(uri)
          account ? Success(account) : Failure("Could not find account for #{uri}")
        end
      end
    end
  end
end
