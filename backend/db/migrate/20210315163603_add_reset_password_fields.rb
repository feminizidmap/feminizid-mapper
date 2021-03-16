# frozen_string_literal: true

class AddResetPasswordFields < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :reset_password_token, default: nil
      t.datetime :reset_password_token_expires_at, default: nil
      t.index :reset_password_token
    end
  end
end
