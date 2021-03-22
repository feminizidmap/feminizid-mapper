# frozen_string_literal: true

class CreateCodelist < ActiveRecord::Migration[6.1]
  def change
    create_table :codelists do |t|
      t.integer :identifier, null: false
      t.string :name, null: false
      t.string :description, null: false, default: ''
      t.string :lang, null: false
      t.timestamps
    end
  end
end
