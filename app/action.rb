# auto_register: false
# frozen_string_literal: true

require "hanami/action"

module Chirper
  class Action < Hanami::Action
    config.formats.add(:json)

    before :set_cors_headers

    def set_cors_headers(req, res)
      res.headers["Access-Control-Allow-Origin"] = "http://localhost:3001"
      res.headers["Access-Control-Allow-Headers"] = 'Content-Type, Authorization'
      res.headers["Access-Control-Request-Method"] = '*'
    end
  end
end
