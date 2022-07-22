# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :get_project
  before_action :set_bug, only: %i[show edit update destroy assign_dev resolve]

  def index
    @bugs = @project.bugs
    @d_bugs = @project.bugs.has_not_ended
    @dev_p_bugs = current_developer.assigned_bugs.has_not_ended.where(project_id: @project.id) if current_developer
  end

  def new
    @bug = @project.bugs.build
    authorize @bug
  end

  def create
    @bug = @project.bugs.build(bug_params)
    assign_qa
    authorize @bug
    if @bug.save
      flash[:notice] = 'Bug added successfully'
      redirect_to project_bugs_path(@project)
    else
      flash[:alert] = 'Bug failed'
      render 'new'
    end
  end

  def update
    authorize @bug
    if @bug.update(bug_params)
      flash[:notice] = 'Bug added successfully'
      redirect_to project_bugs_path(@project)
    else
      flash[:alert] = 'Bug failed'
      render 'new'
    end
  end

  def edit; end

  def show; end

  def destroy
    authorize @bug
    @bug.destroy
    respond_to do |format|
      format.html { flash[:notice] = 'Bug was successfully destroyed.' }
      format.js
    end
  end

  def update_status
    if params[:bugs].present?
      @status = if params[:bugs] == 'Feature'
                  { 'New' => 0, 'Started' => 1, 'Completed' => 2 }
                else
                  { 'New' => 0, 'Started' => 1, 'Resolved' => 2 }
                end
    end
    if request.xhr?
      respond_to do |format|
        format.json do
          render json: { status: @status }
        end
      end
    end
  end

  def assign_dev
    authorize @bug
    if current_developer
      if @bug.update(assignee_id: current_developer.id)
        respond_to do |format|
          format.html { redirect_to root_url, notice: 'Bug was successfully assigned.' }
          format.js
        end
      else
        flash[:alert] = 'Bug was not assigned.'
        redirect_to root_url
      end
    else
      flash[:alert] = 'User is not a developer'
    end
  end

  def resolve
    authorize @bug
    if current_developer
      if @bug.ended!
        respond_to do |format|
          format.html { flash[:notice] = 'Bug was successfully resolved.' }
          format.js
        end
      else
        flash[:alert] = 'Bug was not resolved.'
        redirect_to root_url
      end
    else
      flash[:alert] = 'User is not a developer'
    end
  end

  private

  def get_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Project does not exist'
    redirect_to new_project_url
  end

  def bug_params
    params.require(:bug).permit(:title, :deadline, :bug_type, :status, :remove_ss_image, :ss_image).tap do |p|
      p[:bug_type] = p[:bug_type].to_i if p[:bug_type]
      p[:status] = p[:status].to_i if p[:status]
    end
  end

  def assign_qa
    if current_qa
      @bug.reporter_id = @current_qa.id
    else
      flash[:alert] = 'QA not signed in'
      redirect_to new_user_session_path
    end
  end

  def set_bug
    @bug = @project.bugs.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Bug does not exist'
    redirect_to new_project_bug_url
  end
end
