# frozen_string_literal: true

class AlterCodelistItems < ActiveRecord::Migration[6.1]
  def change
    add_column :codelist_items, :identifier, :integer, not_null: true
    add_reference :codelist_items, :codelist, foreign_key: true, not_null: true
    remove_column :codelist_items, :code, :string
  end
end
