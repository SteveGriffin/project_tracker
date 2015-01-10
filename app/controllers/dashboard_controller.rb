class DashboardController < ApplicationController
	before_action :get_projects, :set_user

	#show.html.erb
	def index	
		binding.pry
	end


	private

	def get_projects
		@projects = Project.where(:user_id => params[:id])
	end

	def set_user
		@user = User.find(params[:id])
	end

end
