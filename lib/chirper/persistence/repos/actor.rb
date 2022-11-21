module Chirper
  module Persistence
    module Repos
      class Actor < ROM::Repository[:actors]
        struct_namespace Chirper

        include Deps[container: "persistence.rom"]
        commands :create

        def find_by_uri(uri)
          actors.where(uri: uri).one
        end

        def find_or_create(uri)
          find_by_uri(uri) || create(uri: uri)
        end
      end
    end
  end
end
