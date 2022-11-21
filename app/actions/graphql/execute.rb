# frozen_string_literal: true

module Chirper
  module Actions
    module Graphql
      class Execute < Chirper::Action
        def handle(req, response)
          result = Chirper::Graphql::Schema.execute(query: req.params[:query])
          response.format = :json
          response.body = result.to_json
        end
      end
    end
  end
end
