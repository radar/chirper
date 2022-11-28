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

        def for_account(account)
          statuses.where(account_id: account.id)
        end

        def count(account)
          for_account(account).count
        end

        def next_20_after(account:, min_id:, max_id:)
          scope = for_account(account)
            .order(statuses[:published].desc)
            .limit(20)

          scope = scope.where { id > min_id } if min_id
          scope = scope.where { id < max_id } if max_id
          scope
        end
      end
    end
  end
end
