module Chirper
  module Operations
    class PostStatus
      include Deps["persistence.repos.status_repo"]

      def call(params)
        status_repo.create(params.merge(published: Time.now))
      end
    end
  end
end
