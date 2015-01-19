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

end
