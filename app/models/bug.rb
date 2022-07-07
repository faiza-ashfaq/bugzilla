# frozen_string_literal: true

class Bug < ApplicationRecord
  # VALIDATIONS
  validates :title, uniqueness: true
  validates :title, :status, :b_type, presence: true
  validates_with BugValidator

  # ENUMS
  enum b_type: { feature: 0, bug: 1 }
  enum status: { New: 0, started: 1, ended: 2 }

  # ASSOCIATIONS
  belongs_to :project
  belongs_to :reporter, class_name: 'User'
  belongs_to :assignee, class_name: 'User'
end
