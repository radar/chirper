module Chirper
  module Persistence
    module Relations
      class Follows < ROM::Relation[:sql]
        schema(:follows, infer: true) do
          associations do
            belongs_to :followee, relation: :actors, foreign_key: :followee_id
            belongs_to :follower, relation: :actors
          end
        end
      end
    end
  end
end
