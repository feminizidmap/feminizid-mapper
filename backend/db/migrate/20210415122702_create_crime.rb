# frozen_string_literal: true

class CreateCrime < ActiveRecord::Migration[6.1]
  def change
    create_table :crimes, id: :uuid do |t|
      t.uuid :location_id, foreign_key: true
      t.string :address
      t.uuid :cause_of_death_id, foreign_key: true
      t.uuid :acts_of_violence_id, foreign_key: true
      t.uuid :weapons_id, foreign_key: true
      t.uuid :ftype_id, foreign_key: true
      t.uuid :motif_id, foreign_key: true
      t.uuid :fcase_id, foreign_key: true
      t.timestamps
    end
  end
end
