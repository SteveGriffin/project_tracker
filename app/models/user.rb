class User < ActiveRecord::Base
	has_secure_password

	has_many :projects, dependent: :destroy
	has_many :tasks, through: :projects
	has_many :sessions, through: :tasks

	validates :email, :password, presence: true
	validates_uniqueness_of :email
end
