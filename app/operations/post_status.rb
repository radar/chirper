module Chirper
  module Operations
    class PostStatus
      include Deps[status_repo: "persistence.repos.status"]

      def call(params)
        status_repo.create(params.merge(published: Time.now))
      end
    end
  end
end
