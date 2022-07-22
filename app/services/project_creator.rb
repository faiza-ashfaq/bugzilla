# frozen_string_literal: true

class ProjectCreator < ApplicationService
  attr_reader :params

  def initialize(params, current_manager)
    @params = params
    @current_manager = current_manager
  end

  def call
    create
  end

  private

  def create
    @project = Project.new(project_params)
    assign_manager
    @project
  end

  def project_params
    @params.require(:project).permit(:name)
  end

  def assign_manager
    if @current_manager
      @project.user_id = @current_manager.id
    else
      flash[:alert] = 'Manager not signed in'
      redirect_to new_user_session_path
    end
  end
end
