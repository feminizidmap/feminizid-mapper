# frozen_string_literal: true

class CreateFields < ActiveRecord::Migration[6.1]
  def change
    create_table :fields, id: :uuid do |t|
      t.string :name, null: false, default: ''
      t.string :description, null: false, default: ''
      t.string :key, null: false, default: ''
      t.string :value, null: false, default: ''
      t.string :feature
      t.references :entity, type: :uuid
      t.timestamps
    end
  end
end
