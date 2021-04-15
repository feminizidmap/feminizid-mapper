# frozen_string_literal: true

class Perpetrator < ActiveRecord::Migration[6.1]
  def change
    create_table :perpetrators, id: :uuid do |t|
      t.string :firstname, null: false, default: ''
      t.string :lastname, null: false, default: ''
      t.integer :age
      t.uuid :gender_id, foreign_key: true
      t.uuid :civil_status_id, foreign_key: true
      t.uuid :educational_background_id, foreign_key: true
      t.uuid :citizenship_type_id, foreign_key: true
      t.string :citizenship
      t.uuid :legal_status_id, foreign_key: true
      t.uuid :alcohol_influence_id, foreign_key: true
      t.uuid :drug_influence_id, foreign_key: true
      t.uuid :previous_psychological_condition_id, foreign_key: true
      t.uuid :previous_criminal_record_id, foreign_key: true
      t.uuid :suicide_afterwards_id, foreign_key: true
      t.uuid :fcase_id, foreign_key: true
      t.timestamps
    end
  end
end
