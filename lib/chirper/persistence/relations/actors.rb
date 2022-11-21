module Chirper
  module Persistence
    module Relations
      class Actors < ROM::Relation[:sql]
        schema(:actors, infer: true)
      end
    end
  end
end
