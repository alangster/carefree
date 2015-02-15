class SessionsController < ApplicationController

	skip_before_action :require_login, except: [:destroy]

	def new
		@user = User.new
	end

	def create
		@user = User.find_by(email: params[:email])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			if @user.admin?
				redirect_to admin_dashboard_path
			else
				redirect_to dashboard_path(@user)
			end
		else
			@error = "Incorrect email and/or password"
			render :new
		end
	end

end