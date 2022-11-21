module Chirper
  module ActivityPub
    class Processor
      include Deps[
        actor_repo: "persistence.repos.actor",
        follow_repo: "persistence.repos.follow",
        status_repo: "persistence.repos.status"
      ]

      def handle(activity)
        case activity
        when ActivityPub::Create
          status_repo.create(
            content: activity.object.content,
            published: activity.published,
          )
        else
          follower = actor_repo.find_or_create(activity.actor)
          followee = actor_repo.find_or_create(activity.object)

          follow_repo.add(
            follower_id: follower.id,
            followee_id: followee.id,
          )
        end
      end
    end
  end
end
