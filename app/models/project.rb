# frozen_string_literal: true

class Project < ApplicationRecord
  #VALIDATIONS
  validates_numericality_of :user_id
  validates_with ProjectValidator


  #ASSOCIATIONS
  belongs_to :user
  has_and_belongs_to_many :users
  has_many :bugs, dependent: :destroy

  scope :by_title,  ->(title) { joins(:users).where(users: { type: title }) }\
end

