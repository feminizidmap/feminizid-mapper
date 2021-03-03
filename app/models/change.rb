# frozen_string_literal: true

class Change < ApplicationRecord
  belongs_to :user

  enum status: { created: 0, updated: 1, deleted: 2, reviewed: 3 }
end
