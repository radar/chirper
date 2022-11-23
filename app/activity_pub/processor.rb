module Chirper
  module ActivityPub
    class Processor
      include Deps[
        create_processor: "activity_pub.processors.create",
        follow_processor: "activity_pub.processors.follow",
      ]

      def handle(activity)
        case activity
        when ActivityPub::Create
          create_processor.(activity)
        else
          follow_processor.(activity.actor, activity.object)
        end
      end
    end
  end
end
