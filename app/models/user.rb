class User < ActiveRecord::Base
	has_secure_password

	has_many :projects, dependent: :destroy
	has_many :projects, through: :collaborators

	validates :email, :password, presence: true
	validates_uniqueness_of :email
end
