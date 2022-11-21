module Chirper
  module Persistence
    module Repos
      class Follow < ROM::Repository[:follows]
        struct_namespace Chirper

        include Deps[container: "persistence.rom"]

        commands :create

        def add(follower_id:, followee_id:)
          f = create(follower_id: follower_id, followee_id: followee_id)
          follows.where(id: f.id).combine(:follower, :followee).one
        end
      end
    end
  end
end
