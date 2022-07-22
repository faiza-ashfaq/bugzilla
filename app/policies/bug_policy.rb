# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  attr_reader :user, :bug

  def initialize(user, bug)
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

  def resolve
    user.developer?
  end

  def assign_dev
    user.developer?
  end
end
