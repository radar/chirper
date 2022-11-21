module Chirper
  module Persistence
    module Repos
      class Status < ROM::Repository[:statuses]
        struct_namespace Chirper

        include Deps[container: "persistence.rom"]
        commands :create


      end
    end
  end
end
