# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :statuses do
      primary_key :id
      column :content, :text, null: false
      column :published, :timestamptz, null: false
    end
  end
end
