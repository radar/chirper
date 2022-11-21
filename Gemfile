# frozen_string_literal: true

source "https://rubygems.org"

gem "hanami", github: "hanami/hanami"
gem "hanami-router", github: "hanami/router"
gem "hanami-controller", github: "hanami/controller"
gem "hanami-validations", github: "hanami/validations"
gem "hanami-utils", github: "hanami/utils"
gem "hanami-cli", github: "hanami/cli"

gem "dry-logger", github: "dry-rb/dry-logger"

gem "dry-types", "~> 1.0", ">= 1.6.1"
gem "dry-monads"
gem "puma"
gem "rake"

group :development, :test do
  gem "dotenv"
  gem "pry"
end

group :cli, :development do
  gem "hanami-reloader", github: "hanami/reloader"
end

group :cli, :development, :test do
  gem "hanami-rspec"
end

group :development do
  gem "guard-puma"
end


group :test do
  gem "rack-test"
  gem "database_cleaner-sequel"
end

gem "graphql", "~> 2.0"

gem "rom", "~> 5.3"
gem "rom-sql", "~> 3.6"
gem "rom-repository"
gem "pg"
