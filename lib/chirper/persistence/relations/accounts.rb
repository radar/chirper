module Chirper
  module Persistence
    module Relations
      class Accounts < ROM::Relation[:sql]
        schema(:accounts, infer: true)
      end
    end
  end
end
