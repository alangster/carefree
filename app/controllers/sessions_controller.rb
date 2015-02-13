class SessionsController < ApplicationController

	skip_before_action :require_login, except: [:destroy]

	def new
	end

	def create
		user = User.find_by(email: params[:email])
		if user && user.password == params[:password]
			session[:user_id] = user.id
		else
			@error = "Incorrect email and/or password"
			render :new
		end
	end

end