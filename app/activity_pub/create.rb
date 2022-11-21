module Chirper
  module ActivityPub
    class Create < Dry::Struct
      attribute :type, Types::String.constrained(eql: "Create")
      attribute :object, ActivityPub::Note
      attribute :published, Types::Params::Time
    end
  end
end
