

# frozen_string_literal: true

require "hanami"
require "graphql"
require "dry/monads"

module Chirper
  class App < Hanami::App
    config.middleware.use :body_parser, :json
  end
end
