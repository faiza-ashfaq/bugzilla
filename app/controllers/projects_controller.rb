# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if current_manager
      @project.user_id = current_manager.id
    else
      flash[:alert] = 'Manager not signed in'
      redirect_to new_user_session_path
    end
    if @project.save
      flash[:notice] = 'Project Successfully Created'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      flash[:notice] = 'Project Successfully Updated'
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { flash[:notice] = 'Project was successfully destroyed.' }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Project does not exist'
    redirect_to new_project_url
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name)
  end
end
