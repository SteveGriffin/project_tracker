class User < ActiveRecord::Base
	has_secure_password

	has_many :projects, dependent: :destroy

	validates :email, :password, presence: true
	validates_uniqueness_of :email
end
