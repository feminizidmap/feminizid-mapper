# frozen_string_literal: true

class UpdateChangeUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :changes, :record, type: :uuid

    add_column :users, :name, :string
  end
end
