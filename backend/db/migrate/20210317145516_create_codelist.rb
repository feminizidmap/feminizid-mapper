class AddOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :codelists do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :description, null: false
      t.string :lang, null: false
      t.timestamps
    end
  end
end
