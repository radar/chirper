Hanami.app.register_provider :persistence, namespace: true do
  prepare do
    require "rom/core"
    require "rom/sql"
    require "rom/repository"

    @config = ROM::Configuration.new(:sql, target["settings"].database_url, extensions: [:pg_timestamptz])
    register "config", @config
    register "db", @config.gateways[:default].connection
  end

  start do
    @config.auto_registration(
      target.root.join("lib/chirper/persistence"),
      namespace: "Chirper::Persistence"
    )

    container = ROM.container(@config)

    register "rom", container

    # TODO: This feels like extra work -- what's the shorter way of doing this?
    register "repos.status", Chirper::Persistence::Repos::Status.new(container: container)
  end
end
