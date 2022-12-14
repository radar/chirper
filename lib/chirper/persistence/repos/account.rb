module Chirper
  module Persistence
    module Repos
      class Account < ROM::Repository[:accounts]
        struct_namespace Chirper

        include Deps[container: "persistence.rom"]
        commands :create

        def find_by_address(address)
          accounts.where(address: address).one
        end

        def find_by_uri(uri)
          accounts.where(uri: uri).one
        end

        def find_or_create(uri)
          find_by_uri(uri) || create(uri: uri, display_name: uri)
        end
      end
    end
  end
end
