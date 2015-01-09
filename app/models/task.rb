class Task < ActiveRecord::Base
	has_many :sessions, dependent: :destroy
end
