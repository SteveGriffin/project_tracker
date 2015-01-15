class Task < ActiveRecord::Base
  has_many :sessions, dependent: :destroy

  #return the total amount of time spent on the task
  #returns a hash of hours and minutes
  def self.total_time(task_id)
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

    result
  end

  #return the sessions for the task
  def self.task_sessions(task_id)
    @current_task = Task.find(task_id)
    @current_task.sessions
  end

  #return the tasks for a given project
  def self.get_project_tasks(project_id)
    @tasks = Task.where(:project_id => project_id)
  end

   #check for active session
  def active_session(project_id)
    @sessions = Session.where(project_id: project_id)

    @sessions.each do |session|
      if session.end_time == nil
        session[:active_session] = true
      end

      if session[:active_session]
        flash[:notice] = "active session in progress"
      end
    end
  end
  
end
