class Session < ActiveRecord::Base
  belongs_to :projects
  belongs_to :tasks

end
