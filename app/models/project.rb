# frozen_string_literal: true

class Project < ApplicationRecord
  # VALIDATIONS
  validates :name, presence: true
  validates :user_id, numericality: true
  validates_with ProjectValidator

  # ASSOCIATIONS
  belongs_to :user
  has_and_belongs_to_many :users
  has_many :bugs, dependent: :destroy

  # FUNCTIONS
  def developers
    users.select { |x| x.type == 'Developer' }
  end

  def qas
    users.select { |x| x.type == 'QA' }
  end

  def creator
    user
  end
end
