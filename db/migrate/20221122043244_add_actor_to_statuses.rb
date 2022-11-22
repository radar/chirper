# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :statuses do
      add_foreign_key :actor_id, :actors
    end
  end
end
