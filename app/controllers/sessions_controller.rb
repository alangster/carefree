class SessionsController < ApplicationController

	skip_before_action :require_login, except: [:destroy]

	def new
	end

	def create
		user = User.find_by(email: params[:email])
		p user
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			if current_user.admin?
				p "ADMIN"
				redirect_to admin_dashboard_path
			else

			end
		else
			@error = "Incorrect email and/or password"
			render :new
		end
	end

end