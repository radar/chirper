module Chirper
  module ActivityPub
    class Processor
      include Deps[
        status_repo: "persistence.repos.status",
        follow_processor: "activity_pub.processors.follow"
      ]

      def handle(activity)
        case activity
        when ActivityPub::Create
          status_repo.create(
            content: activity.object.content,
            published: activity.published,
          )
        else
          follow_processor.(activity.actor, activity.object)
        end
      end
    end
  end
end
