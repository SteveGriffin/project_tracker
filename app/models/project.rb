class Project < ActiveRecord::Base
	has_many :sessions, dependent: :destroy
	belongs_to :user
end
