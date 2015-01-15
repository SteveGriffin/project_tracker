class DashboardController < ApplicationController
  before_action :get_projects, :set_user, :active_session

  #show.html.erb
  def index
  end

  def new_task
    #session[:project_id] = params[:id]
    session[:user_id] = @user.id
    #redirect to new task page with project_id in params
    redirect_to new_task_path( :project_id => params[:id])
  end


  private

  def get_projects
    @projects = Project.where(:user_id => params[:id])
  end

  def set_user
    @user = User.find(params[:id])
    #TEMP
    session[:user_id] = @user.id
  end



end
