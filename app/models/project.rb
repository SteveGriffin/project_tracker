class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators
  has_many :sessions, through: :tasks, dependent: :destroy
  belongs_to :user


  #get active session for project
  #returns a hash of session_id and task_id
  def self.active_session(project_id)
    @project = Project.find(project_id)
    @sessions = @project.sessions

    result = Hash.new
    @sessions.each do |session|
      if session.active == true
        result[:session_id] = session.id
        result[:task_id] = session.task_id
      else
      end
    end

    result
  end

  #return boolean indicating whether project has been completed
  def self.complete?(project_id)
    @project = Project.find(project_id)
    completion_status = @project.completion_date
    if completion_status
      true
    else
      false
    end
  end

  #return project collaborators
  def self.collaborators(project_id)
    @project = Project.find(project_id)
    @collaborators = @project.users
  end

  #return projects that a specific user collaborates on
  def self.collaborations(user_id)
    @collaborations = Collaborator.find(user_id: user_id)
  end

  #total time spent on the project, returns a hash of minutes and hours
  def self.total_time(project_id)
    @project = Project.find(project_id)
    @sessions = @project.sessions

    total = 0
    @sessions.each do |session|
      if session.start_time != nil && session.end_time != nil
        time = (session.end_time - session.start_time) / 60
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

      #if minutes are rounded up to 60 total, increment hours and set minutes to zero
      if minutes == 60
        hours += 1
        minutes = 0
      end
    end

    #create and return hash of hours and minutes
    result = Hash.new
    result[:hours] = hours
    result[:minutes] = minutes
    #return result
    result
  end

  #output project object as csv data
  def self.csv(project)
    @sessions = project.sessions
    @total_time = self.total_time(project.id)

    CSV.generate do |csv|
      csv << column_names
      csv << project.attributes.values_at(*column_names)
      csv << ["Work Sessions"]
      @sessions.each do |session|
        csv << session.attributes.values_at("start_time", "end_time")
      end

      csv << ["Hours", "Minutes"]
      csv << @total_time.values
    end
  end

end
