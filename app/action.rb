# auto_register: false
# frozen_string_literal: true

require "hanami/action"

module Chirper
  class Action < Hanami::Action
    config.formats.add(:json)
  end
end
