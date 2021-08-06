# frozen_string_literal: true

class CreateSources < ActiveRecord::Migration[6.1]
  def change
    create_table :sources, id: :uuid do |t|
      t.string :url, null: false, default: ''
      t.references :record, type: :uuid
      t.timestamps
    end
  end
end
