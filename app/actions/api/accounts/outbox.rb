# frozen_string_literal: true
module Chirper
  module Actions
    module API
      module Accounts
        class Outbox < Chirper::Action
          PUBLIC_URL = "https://www.w3.org/ns/activitystreams#Public"
          include Deps[
            "persistence.repos.account_repo",
            "persistence.repos.status_repo"
          ]

          params do
            required(:username).value(:string)
            optional(:page).value(:bool)
            optional(:max_id).value(:integer)
            optional(:min_id).value(:integer)
          end

          def handle(req, response)
            response.format = :json

            username = req.params[:username]
            account = account_repo.find_by_uri("#{Hanami.app.config.base_url}/@#{username}")
            unless account
              response.status = 404
              response.body = {
                error: "Not found"
              }
              return
            end

            response.body = if req.params[:page]
              ordered_collection_page(req.params)
            else
              collection(req.params)
            end
          end

          private

          def find_account(username)
            account_repo.find_by_uri("#{Hanami.app.config.base_url}/@#{username}")
          end

          def collection(params)
            username = params[:username]
            account = find_account(username)
            {
              "@context": "https://www.w3.org/ns/activitystreams",
              "id": routes.url(:outbox, username: username),
              "type": "OrderedCollection",
              "totalItems": status_repo.count(account),
              "first": routes.url(:outbox, username: username, page: true),
              "last": routes.url(:outbox, username: username, min_id: 0, page: true),

            }.to_json
          end

          def ordered_collection_page(params)
            username = params[:username]
            account = find_account(username)

            statuses = status_repo.next_20_after(
              # TODO: This probably needs a programmatic way of being defined
              account: account,
              min_id: params[:min_id],
              max_id: params[:max_id]
            ).to_a

            next_url = if statuses.count == 20
              routes.url(:outbox, username: username, page: true, max_id: statuses.last.id)
            else
              nil
            end

            {
              "@context": "https://www.w3.org/ns/activitystreams",
              "id": routes.url(:outbox, username: username, page: params[:page]),
              "type": "OrderedCollectionPage",
              "next": next_url,
              "prev": routes.url(:outbox, username: username, page: true, min_id: statuses.first.id),
              "partOf": routes.url(:outbox, username: username),
              "orderedItems": (statuses.map do |status|
                {
                  "id": routes.url(:status_activity, username: username, id: status.id),
                  type: "Create",
                  actor: account.uri,
                  published: status.published.iso8601,
                  to: [PUBLIC_URL],
                  cc: [
                    routes.url(:followers, username: username),
                  ],
                  object: {
                    id: routes.url(:status, username: username, id: status.id),
                    url: routes.url(:status, username: username, id: status.id),
                    type: "Note",
                    published: status.published.iso8601,
                    content: status.content,
                    to: [PUBLIC_URL],
                    cc: [
                      routes.url(:followers, username: username),
                    ]
                  }
                }
              end)
            }.to_json
          end

        end
      end
    end
  end
end
