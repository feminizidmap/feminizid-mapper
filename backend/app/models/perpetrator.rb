# frozen_string_literal: true

class Perpetrator < ApplicationRecord
  self.implicit_order_column = 'created_at'

  belongs_to :fcase

  belongs_to :alcohol_influence, class_name: 'YesNo', optional: true
  belongs_to :drug_influence, class_name: 'YesNo', optional: true
  belongs_to :previous_psychological_condition, class_name: 'YesNo', optional: true
  belongs_to :previous_criminal_record, class_name: 'YesNo', optional: true
  belongs_to :suicide_afterwards, class_name: 'YesNo', optional: true

  belongs_to :gender, class_name: 'CodelistItem', optional: true
  belongs_to :civil_status, class_name: 'CodelistItem', optional: true
  belongs_to :educational_background, class_name: 'CodelistItem', optional: true
  belongs_to :citizenship_type, class_name: 'CodelistItem', optional: true
  belongs_to :legal_status, class_name: 'CodelistItem', optional: true

  accepts_nested_attributes_for :alcohol_influence
  accepts_nested_attributes_for :drug_influence
  accepts_nested_attributes_for :previous_psychological_condition
  accepts_nested_attributes_for :previous_psychological_condition
  accepts_nested_attributes_for :previous_criminal_record
  accepts_nested_attributes_for :suicide_afterwards

  scope :by_alcohol_answer, ->(answer) { Perpetrator.joins(:alcohol_influence).merge(YesNo.is(answer)) }
  scope :by_drug_answer, ->(answer) { Perpetrator.joins(:drug_influence).merge(YesNo.is(answer)) }
  scope :by_pyschological_condition_answer, ->(answer) { Perpetrator.joins(:previous_psychological_condition).merge(YesNo.is(answer)) }
  scope :by_criminal_record_answer, ->(answer) { Perpetrator.joins(:previous_criminal_record).merge(YesNo.is(answer)) }
  scope :by_suicide_answer, ->(answer) { Perpetrator.joins(:suicide_afterwards).merge(YesNo.is(answer)) }

  scope :by_gender, ->(name) { Perpetrator.joins(:gender).merge(CodelistItem.by_name(name)) }
  scope :by_civil_status, ->(name) { Perpetrator.joins(:civil_status).merge(CodelistItem.by_name(name)) }
  scope :by_educational_background, ->(name) { Perpetrator.joins(:educational_background).merge(CodelistItem.by_name(name)) }
  scope :by_citizenship_type, ->(name) { Perpetrator.joins(:citizenship_type).merge(CodelistItem.by_name(name)) }
  scope :by_legal_status, ->(name) { Perpetrator.joins(:legal_status).merge(CodelistItem.by_name(name)) }
end
