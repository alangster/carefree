class AdminController < ApplicationController
	
	before_action :require_admin

	private

	def require_admin
		redirect_to :back unless current_user.admin?
	end

end