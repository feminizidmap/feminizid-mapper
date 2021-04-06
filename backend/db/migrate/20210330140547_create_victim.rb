# frozen_string_literal: true

class CreateVictim < ActiveRecord::Migration[6.1]
  def change
    create_table :victims, id: :uuid do |t|
      t.string :firstname, null: false, default: ''
      t.string :lastname, null: false, default: ''
      t.integer :age
      t.uuid :civil_status_id, foreign_key: true
      t.uuid :educational_background_id, foreign_key: true
      t.string :address
      t.uuid :citizenship_type_id, foreign_key: true
      t.string :citizenship
      t.uuid :legal_status_id, foreign_key: true
      t.uuid :drunk_id, foreign_key: true
      t.uuid :drug_influence_id, foreign_key: true
      t.uuid :previous_reports_of_violence_id, foreign_key: true
      t.timestamps
    end
  end
end
