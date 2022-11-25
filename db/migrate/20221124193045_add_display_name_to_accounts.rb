# frozen_string_literal: true

ROM::SQL.migration do
  change do
    add_column :accounts, :display_name, :text, null: false
  end
end
