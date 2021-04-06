# frozen_string_literal: true

class AlterCodelistItems < ActiveRecord::Migration[6.1]
  def change
    change_table :codelist_items, bulk: true do |t|
      t.integer :identifier, not_null: true
      t.uuid :codelist_id, foreign_key: true, not_null: true
    end
    remove_column :codelist_items, :code, :string
  end
end
