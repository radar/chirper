# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :accounts do
      add_column :address, String
    end
  end
end
