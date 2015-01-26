class DashboardController < ApplicationController
  before_action :get_projects, :authenticate

  #show.html.erb
  def index
  end

  def show
     #binding.pry
    if @current_user.id != params[:id].to_i
      redirect_to dashboard_path(@current_user.id) unless admin? == true
    else
    end
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

end
