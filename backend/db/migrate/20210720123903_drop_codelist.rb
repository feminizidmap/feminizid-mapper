class DropCodelist < ActiveRecord::Migration[6.1]
  def change
    drop_table :codelists
    drop_table :codelist_items
  end
end
