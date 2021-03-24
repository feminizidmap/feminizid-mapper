# frozen_string_literal: true

class CreateSystemSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :system_settings do |t|
      t.string :key, null: false
      t.string :value, null: false
      t.timestamps
      t.index :key
    end
  end
end
