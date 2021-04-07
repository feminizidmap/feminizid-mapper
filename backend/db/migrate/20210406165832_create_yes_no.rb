# frozen_string_literal: true

class CreateYesNo < ActiveRecord::Migration[6.1]
  def change
    create_table :yes_nos, id: :uuid do |t|
      t.integer :answer, :integer
      t.timestamps
    end
  end
end
