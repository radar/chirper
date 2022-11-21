# frozen_string_literal: true

module Chirper
  module Actions
    module API::Users
      class Inbox < Chirper::Action
        include Deps["activity_pub.processor"]
        def handle(request, response)
          activity = ActivityPub::Activity.new(request.params.to_h.except(:username))
          status = processor.handle(activity)

          response.format = :json
          response.body = { ok: true }.to_json
        end
      end
    end
  end
end
