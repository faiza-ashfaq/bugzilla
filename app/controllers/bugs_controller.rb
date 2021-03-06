# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :get_project

  def index
    @bugs = @project.bugs
  end

  def new
    @bug = @project.bugs.build
  end

  def create
    @bug = @project.bugs.build(bug_params)
    if @bug.save
      flash[:notice] = 'Bug added successfully'
      redirect_to project_bugs_path(@project)
    else
      flash[:alert] = 'Bug failed'
      render 'new'
    end
  end

  private

  def get_project
    @project = Project.find(params[:project_id])
  end

  def bug_params
    params.require(:project).permit(:name)
  end

  def set_bug
    @bug = @project.bugs.find(params[:id])
  end
end
