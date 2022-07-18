class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def index?
    true
  end

  def create?
    user.manager?
  end

  def new?
    user.manager?
  end

  def update?
    #byebug
    return true if user.manager? && user == project.user
  end

  def destroy?
    return true if user.manager? && user == project.user
  end

  private

    def project
      record
    end
end
