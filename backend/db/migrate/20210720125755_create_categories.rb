# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name, null: false, default: ''
      t.string :description, null: false, default: ''
      t.string :slug, null: false, default: ''
      t.timestamps
    end

    create_table :category_items, id: :uuid do |t|
      t.string :name, null: false, default: ''
      t.string :description, null: false, default: ''
      t.string :slug, null: false, default: ''
      t.references :category, type: :uuid
      t.timestamps
    end

    create_table :attributes, id: :uuid do |t|
      t.references :entity, type: :uuid
      t.references :category, type: :uuid
      t.references :category_item, type: :uuid
      t.timestamps
    end
  end
end
