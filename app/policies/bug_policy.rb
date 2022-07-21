# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, _project)
    @user = user
    @bug = bug
  end

  def index?
    true
  end

  def create?
    user.qa?
  end

  def new?
    user.qa?
  end

  def update?
    return true if user.qa? && user == bug.user
  end

  def destroy?
    return true if user.qa? && user == bug.user
  end
end
