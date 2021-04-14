# frozen_string_literal: true

class CreateFcase < ActiveRecord::Migration[6.1]
  def change
    create_table :fcases, id: :uuid do |t|
      t.string :ident, null: false
      t.string :sources
      t.timestamps
    end

    add_index :fcases, :ident
  end
end
