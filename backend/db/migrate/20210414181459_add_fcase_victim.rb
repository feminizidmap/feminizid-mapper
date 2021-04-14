# frozen_string_literal: true

class AddFcaseVictim < ActiveRecord::Migration[6.1]
  def change
    add_column :victims, :fcase_id, :uuid
  end
end
