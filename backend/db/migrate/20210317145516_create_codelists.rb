# frozen_string_literal: true

class CreateCodelists < ActiveRecord::Migration[6.1]
  def change
    create_table :codelists, id: :uuid do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :description, null: false
      t.string :lang, null: false
      t.timestamps
    end
  end
end
