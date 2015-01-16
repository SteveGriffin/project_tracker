class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
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
end
