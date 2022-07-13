# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  # VALIDATIONS
  validates :username, :email, :type, presence: true
  validates :username, :email, uniqueness: true

  # ASSOCIATIONS
  has_many :projects, dependent: :destroy
  has_and_belongs_to_many :projects
  has_many :reported_bugs, class_name: 'Bugs', foreign_key: 'reporter_id', dependent: :destroy, inverse_of: :user
  has_many :assigned_bugs, class_name: 'Bugs', foreign_key: 'assignee_id', dependent: :destroy, inverse_of: :user

  def manager?
    type == 'Manager'
  end

  def qa?
    type == 'QA'
  end

  def developer?
    type == 'Developer'
  end
end