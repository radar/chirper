Hanami.app.register_provider :persistence, namespace: true do
  prepare do
    require "rom/core"
    require "rom/sql"
    require "rom/repository"

    @config = ROM::Configuration.new(:sql, target["settings"].database_url, extensions: [:pg_timestamptz])
    default_connection = @config.gateways[:default].connection
    default_connection.loggers << Logger.new("log/#{Hanami.env}.log")
    register "config", @config
    register "db", default_connection
  end

  start do
    @config.auto_registration(
      target.root.join("lib/chirper/persistence"),
      namespace: "Chirper::Persistence"
    )

    container = ROM.container(@config)

    register "rom", container

    # TODO: This feels like extra work -- what's the shorter way of doing this?
    register "repos.follow_repo", Chirper::Persistence::Repos::Follow.new(container: container)
    register "repos.status_repo", Chirper::Persistence::Repos::Status.new(container: container)
    register "repos.account_repo", Chirper::Persistence::Repos::Account.new(container: container)
  end
end
