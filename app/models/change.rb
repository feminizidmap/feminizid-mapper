class Change < ApplicationRecord
  belongs_to :user

  enum status: [:created, :updated, :deleted, :reviewed]
end
