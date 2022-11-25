# frozen_string_literal: true
module Chirper
  module Actions
    module API
      module Accounts
        class Inbox < Chirper::Action
          include Deps["activity_pub.processor"]
          def handle(request, response)
            params = request.params.to_h.except(:username)
            type = params[:type]
            case type
            when "Create"
              activity = ActivityPub::Create.new(params)
            when "Follow"
              activity = ActivityPub::Follow.new(params)
            end

            processor.handle(activity)

            response.format = :json
            response.body = { ok: true }.to_json
          end
        end
      end
    end
  end
end
