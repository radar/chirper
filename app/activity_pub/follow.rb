module Chirper
  module ActivityPub
    class Follow < Dry::Struct
      attribute :type, Types::String.constrained(eql: "Follow")
      attribute :object, Types::String
      attribute :actor, Types::String
    end
  end
end
