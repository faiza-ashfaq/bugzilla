# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
    @u_projects = current_user.projects if current_user
    authorize @projects
  end

  def new
    @project = Project.new
    @devs = User.where.not(id: @project.users.collect(&:id)).by_title('Developer')
    @qas = User.where.not(id: @project.users.collect(&:id)).by_title('Qa')
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @users_projects = params.require(:project).permit(user_id: [])
    assign_manager
    authorize @project
    if @project.save
      add_user_to_projects(@users_projects, @project)
      flash[:notice] = 'Project Successfully Created'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @devs = User.where.not(id: @project.users.collect(&:id)).by_title('Developer')
    @qas = User.where.not(id: @project.users.collect(&:id)).by_title('Qa')
  end

  def update
    @users_projects = params.require(:project).permit(user_id: [])
    if @project.update(project_params)
      add_user_to_projects(@users_projects, @project)
      authorize @project
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

  def assign_manager
    if current_manager
      @project.user_id = current_manager.id
    else
      flash[:alert] = 'Manager not signed in'
      redirect_to new_user_session_path
    end
  end

  def add_user_to_projects(users_projects, proj)
    users_projects = users_projects.values
    users_projects = users_projects[0].select!(&:present?)
    users_projects.each do |user|
      u = User.find_by(id: user)
      proj.users << u unless u.nil?
    end
  end

  def current_user
    # byebug
    current_manager || current_developer || current_qa
  end
end
