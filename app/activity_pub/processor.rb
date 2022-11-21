module Chirper
  module ActivityPub
    class Processor
      include Deps[status_repo: "persistence.repos.status"]

      def handle(activity)
        status_repo.create(
          content: activity.object.content,
          published: activity.published,
        )
      end
    end
  end
end
