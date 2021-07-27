# frozen_string_literal: true

class AddNewEntitySystem < ActiveRecord::Migration[6.1]
  def change
    create_table :records, id: :uuid do |t|
      t.string :identifier, null: false, default: ''
      t.integer :version, null: false, default: 1
      t.timestamps
    end

    create_table :entities, id: :uuid do |t|
      t.string :name, null: false, default: ''
      t.string :slug, null: false, unique: true
      t.string :description, null: false, default: ''
      t.references :record, type: :uuid
      t.timestamps
    end
  end
end
