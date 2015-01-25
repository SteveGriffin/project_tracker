class User < ActiveRecord::Base
  has_secure_password

  has_many :projects, dependent: :destroy
  has_many :tasks, through: :projects
  has_many :sessions, through: :tasks

  validates :email, :password, presence: true
  validates_uniqueness_of :email


  def self.create_with_omniauth(auth)
  	#binding.pry
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = "TestUser" #auth["info"]["nickname"]
      user.password = "test"
      user.email = auth["info"]["email"]
    end
  end
end
