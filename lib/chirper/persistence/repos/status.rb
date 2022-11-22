module Chirper
  module Persistence
    module Repos
      class Status < ROM::Repository[:statuses]
        struct_namespace Chirper

        include Deps[container: "persistence.rom"]
        commands :create

        def timeline
          statuses.combine(:account).order(statuses[:published].desc)
        end
      end
    end
  end
end
