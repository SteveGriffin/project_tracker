class Session < ActiveRecord::Base
  belongs_to :project
  belongs_to :task
  has_one :user, through: :project

  validates :start_time, :end_time, overlap: {message: "asdfasdf" , scope: 'project_id'}

end
