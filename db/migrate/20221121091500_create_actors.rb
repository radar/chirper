# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :actors do
      primary_key :id
      column :uri, :text, null: false
    end
  end
end
