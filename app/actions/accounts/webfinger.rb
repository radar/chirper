# frozen_string_literal: true

module Chirper
  module Actions
    module Accounts
      class Webfinger < Chirper::Action
        include Deps[account_repo: "persistence.repos.account"]

        def handle(request, response)
          account = account_repo.find_by_address(request.params[:id])
          unless account
            response.status = 404
            return
          end

          response.format = :json
          response.body = {
            subject: "acct:#{account.address}",
            aliases: [account.uri],
            links: [
              {
                rel: "http://webfinger.net/rel/profile-page",
                type: "text/html",
                href: account.uri
              },
              {
                rel: "self",
                type: "application/activity+json",
                href:  routes.url(:account, id: account.address)
              },
              {
                rel: "http://ostatus.org/schema/1.0/subscribe",
                template: "#{Hanami.app.config.base_url}/authorize_interaction?uri={uri}"
              }
            ]
          }.to_json
        end
      end
    end
  end
end
