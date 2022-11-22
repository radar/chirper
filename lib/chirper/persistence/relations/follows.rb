module Chirper
  module Persistence
    module Relations
      class Follows < ROM::Relation[:sql]
        schema(:follows, infer: true) do
          associations do
            belongs_to :followee, relation: :accounts, foreign_key: :followee_id
            belongs_to :follower, relation: :accounts
          end
        end
      end
    end
  end
end
