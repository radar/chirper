module Chirper
  module Persistence
    module Relations
      class Statuses < ROM::Relation[:sql]
        schema(:statuses, infer: true) do
          associations do
            belongs_to :actor
          end
        end
      end
    end
  end
end
