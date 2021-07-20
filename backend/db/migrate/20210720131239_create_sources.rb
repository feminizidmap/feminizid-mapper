# frozen_string_literal: true

class CreateSources < ActiveRecord::Migration[6.1]
  def change
    create_table :sources, id: :uuid do |t|
      t.string :url, null: false, default: ''
      t.timestamps
    end

    add_reference :sources, :record
  end
end
