# frozen_string_literal: true

module Chirper
  module Actions
    module Accounts
      class Followers < Chirper::Action
        def handle(*, response)
          response.body = self.class.name
        end
      end
    end
  end
end
