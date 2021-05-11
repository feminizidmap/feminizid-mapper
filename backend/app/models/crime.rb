# frozen_string_literal: true

class Crime < ApplicationRecord
  self.implicit_order_column = 'created_at'

  belongs_to :fcase
  has_many :victims, through: :fcase
  has_many :perpetrators, through: :fcase

  belongs_to :location, class_name: 'CodelistItem', optional: true
  belongs_to :cause_of_death, class_name: 'CodelistItem', optional: true
  belongs_to :acts_of_violence, class_name: 'CodelistItem', optional: true
  belongs_to :weapons, class_name: 'CodelistItem', optional: true
  belongs_to :ftype, class_name: 'CodelistItem', optional: true
  belongs_to :motif, class_name: 'CodelistItem', optional: true

  scope :by_location, ->(name) { Crime.joins(:location).merge(CodelistItem.by_name(name)) }
  scope :by_cause_of_death, ->(name) { Crime.joins(:cause_of_death).merge(CodelistItem.by_name(name)) }
  scope :by_acts_of_violence, ->(name) { Crime.joins(:acts_of_violence).merge(CodelistItem.by_name(name)) }
  scope :by_weapons, ->(name) { Crime.joins(:weapons).merge(CodelistItem.by_name(name)) }
  scope :by_feminicide_type, ->(name) { Crime.joins(:ftype).merge(CodelistItem.by_name(name)) }
  scope :by_motif, ->(name) { Crime.joins(:motif).merge(CodelistItem.by_name(name)) }
end
