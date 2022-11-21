module Chirper
  module Persistence
    module Relations
      class Statuses < ROM::Relation[:sql]
        schema(:statuses, infer: true)
      end
    end
  end
end
