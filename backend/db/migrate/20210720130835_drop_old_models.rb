# frozen_string_literal: true

class DropOldModels < ActiveRecord::Migration[6.1]
  def change
    drop_table :crimes
    drop_table :fcases
    drop_table :perpetrators
    drop_table :victims
    drop_table :yes_nos
  end
end
