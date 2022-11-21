module Chirper
  module Persistence
    module Repos
      class Actor < ROM::Repository[:actors]
        struct_namespace Chirper

        include Deps[container: "persistence.rom"]
        commands :create

        def find_or_create(uri)
          actors.where(uri: uri).one || create(uri: uri)
        end
      end
    end
  end
end
