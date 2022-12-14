module Chirper
  module ActivityPub
    module Processors
      class Follow
        include Dry::Monads[:result, :do]
        include Deps[
          "persistence.repos.account_repo",
          "persistence.repos.follow_repo",
        ]

        def call(follower, followee)
          followee = yield find_followee(followee)
          follower = yield find_or_create_follower(follower)
          create_follow(followee, follower)
        end

        def find_followee(followee)
          actor = account_repo.find_by_uri(followee)
          actor ? Success(actor) : Failure("Could not find actor for uri=#{followee}")
        end

        def find_or_create_follower(follower)
          Success(account_repo.find_or_create(follower))
        end

        def create_follow(followee, follower)
          follow = follow_repo.add(
            follower_id: follower.id,
            followee_id: followee.id,
          )
          Success(follow)
        end
      end
    end
  end
end
