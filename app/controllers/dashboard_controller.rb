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


  helper_method :get_tasks

  def get_tasks(id)
    @tasks = Task.where(:project_id => id)
  end

  helper_method :task_sessions
  def task_sessions(task_id)
    @current_task = Task.find(task_id)
    @current_task.sessions
  end

  #check for active session
  def active_session
    @sessions = Session.where(project_id: session[:project_id])

    @sessions.each do |session|
      if session.end_time == nil
        session[:active_session] = true
      end

      if session[:active_session]
        flash[:notice] = "active session in progress"
      end
    end
  end

  #calculate the total time spent on the task
  #return number of minutes as integer
  helper_method :total_time
  def total_time(task_id)

    @current_task = Task.find(task_id)
    @task_sessions = @current_task.sessions

    total = 0


    @task_sessions.each do |task|
      if task.start_time != nil && task.end_time != nil
        time = (task.start_time - task.end_time) / 60
        total += time
      end
    end
    
    hours = total / 60
    minutes = total % 60
    result = Hash.new
    result[:hours] = hours
    result[:minutes] = minutes


    return result
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
