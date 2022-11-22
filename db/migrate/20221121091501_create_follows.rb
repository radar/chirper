# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :follows do
      primary_key :id
      foreign_key :follower_id, :accounts
      foreign_key :followee_id, :accounts
    end
  end
end
