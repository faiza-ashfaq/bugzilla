# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  def index;
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create;
    @project = Project.new(project_params)
    @project.user_id = current_manager.id if current_manager
    if @project.save
      flash[:success] = "Project Successfully Created"
      redirect_to root_url
    end
  end

  def edit; end

  def show; end

  def destroy
    @project.destroy
    redirect_to root_url, notice: "Project was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name)
    end
end
