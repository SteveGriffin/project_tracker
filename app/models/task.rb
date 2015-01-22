class Task < ActiveRecord::Base
  has_many :sessions, dependent: :destroy
  belongs_to :project
  has_one :user, through: :project

  #return the total amount of time spent on the task
  #returns a hash of hours and minutes
  def self.total_time(task_id)
    @current_task = Task.find(task_id)
    @task_sessions = @current_task.sessions

    total = 0

    @task_sessions.each do |task|
      if task.start_time != nil && task.end_time != nil
        time = (task.end_time - task.start_time) / 60
        total += time
      end
    end

    #if less than an hours spent, pass back minutes and zero hours
    if (total / 60) < 1
      hours = 0
      #round up to closest minute
      minutes = total.ceil
    else
      #divmod returns the quotient and the remainder to get the hours and minutes
      hours, minutes= total.divmod(60)
      #round the minutes
      minutes = minutes.ceil
    end

    #create and return hash of hours and minutes
    result = Hash.new
    result[:hours] = hours
    result[:minutes] = minutes
    #return result
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


end
