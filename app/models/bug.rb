# frozen_string_literal: true

class Bug < ApplicationRecord
  #VALIDATIONS
  validates :title, uniqueness: true
  validates :title, :status, :b_type, presence: true
  validates_with BugValidator

  #ENUMS
  enum b_type: [ :feature, :bug ]
  enum status: [ :New, :started, :ended]

  #ASSOCIATIONS
  belongs_to :project
  belongs_to :reporter, class_name: 'User'
  belongs_to :assignee, class_name: 'User'
end
