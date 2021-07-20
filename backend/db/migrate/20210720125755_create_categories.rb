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
      t.timestamps
    end

    add_reference :category_items, :category

    create_table :attributes, id: :uuid, &:timestamps

    add_reference :attributes, :entity
    add_reference :attributes, :category
    add_reference :attributes, :category_item
  end
end
