# frozen_string_literal: true

class User < ApplicationRecord
  #VALIDATIONS
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true

  # ASSOCIATIONS
  has_many :projects, dependent: :destroy
  has_and_belongs_to_many :projects
  has_many :reported_bugs, class_name: 'Bugs', foreign_key: 'reporter_id', dependent: :destroy, inverse_of: :user
  has_many :assigned_bugs, class_name: 'Bugs', foreign_key: 'assignee_id', dependent: :destroy, inverse_of: :user


  def manager?
    if self.type=="Manager"
      true
    end
  end
  def qa?
    if self.type=="QA"
      true
    end
  end
  def developer?
    if self.type=="Developer"
      true
    end
  end
end
