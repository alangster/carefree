class SessionsController < ApplicationController

	skip_before_action :require_login, except: [:destroy]

	def new
	end

	def create
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			if params[:remember_me]
				cookies.permanent[:auth_token] = user.auth_token
			else
				cookies[:auth_token] = user.auth_token
			end
			if user.admin?
				redirect_to admin_dashboard_path
			else
				redirect_to dashboard_path(user)
			end
		else
			@error = "Incorrect email and/or password"
			render :new
		end
	end

	def destroy
		cookies.delete(:auth_token)
		redirect_to :root
	end

end