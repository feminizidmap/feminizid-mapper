class RenameCodelistsToCodelistitem < ActiveRecord::Migration[6.1]
  def up
    rename_table :codelists, :codelist_items
  end

  def down
    rename_table :codelist_items, :codelists
  end
end
