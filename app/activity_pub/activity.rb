module Chirper
  module ActivityPub

    class Note < Dry::Struct
      attribute :type, Types::String.constrained(eql: "Note")
      attribute :content, Types::String
      attribute :published, Types::Params::DateTime
    end

    Object = Note

    class Activity < Dry::Struct
      attribute :type, Types::String.constrained(eql: "Create")
      attribute :object, ActivityPub::Object
      attribute :published, Types::Params::Time

    end
  end
end
