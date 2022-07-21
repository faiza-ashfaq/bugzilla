# frozen_string_literal: true

class Bug < ApplicationRecord
  attr_accessor :remove_ss_image

  # VALIDATIONS
  validates :title, uniqueness: true
  validates :title, :status, :bug_type, presence: true
  validates :ss_image, attached: false, content_type: [:png, :gif]#, :message => "Only gif and png files are allowed for screenshots"
  validates_with BugValidator, unless: :has_reporter? || :has_assignee?

  # ENUMS
  enum bug_type: { feature: 0, bug: 1 }
  enum status: { New: 0, started: 1, ended: 2 }

  # ASSOCIATIONS
  belongs_to :project
  belongs_to :reporter, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true
  has_one_attached :ss_image

  # FUNCTIONS
  def has_reporter?
    reporter.present?
  end

  def has_assignee?
    assignee.present?
  end
end
