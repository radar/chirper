module Chirper
  module ActivityPub
    class Note < Dry::Struct
      attribute :type, Types::String.constrained(eql: "Note")
      attribute :content, Types::String
      attribute :published, Types::Params::DateTime
    end
  end
end
