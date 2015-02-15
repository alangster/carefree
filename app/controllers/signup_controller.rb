class SignupController < ApplicationController

	skip_before_action :require_login

	def new_office
		if @office = Office.find_by(join_token: params[:office_join_token])
			@user = User.new
		else
			redirect_to :root
		end
	end

end