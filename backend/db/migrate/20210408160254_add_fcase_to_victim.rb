# frozen_string_literal: true

class AddFcaseToVictim < ActiveRecord::Migration[6.1]
  def change
    add_column :victims, :fcase_id, :uuid, not_null: true
  end
end
