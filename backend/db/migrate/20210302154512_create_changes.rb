# frozen_string_literal: true

class CreateChanges < ActiveRecord::Migration[6.1]
  def change
    create_table :changes, id: :uuid do |t|
      t.uuid :user_id, null: false, foreign_key: true
      t.integer :status, null: false
      t.timestamps
    end
  end
end
