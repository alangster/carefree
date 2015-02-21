class SignupController < ApplicationController

	skip_before_action :require_login

	def new_office
		if @office = Office.find_by(join_token: params[:office_join_token])
			@user = User.new
		else
			redirect_to :root
		end
	end
 
	def office_contact
		if @office = Office.find_by(join_token: params[:office_join_token])
			@user = User.new(new_user_params)
			@user.office = @office 
			@user.role = Role.find_by(name: 'HR')
			if @user.save
				cookies[:auth_token] = @user.auth_token
				redirect_to dashboard_path(@user)
			else
				render 'new_office'
			end
		else
			redirect_to :root
		end
	end

	def new_hire_join
		if @cohort = Cohort.includes(:office).find_by(join_token: params[:join_token])
			@user = User.new
			render 'new_hire_join'
		else
			redirect_to :root
		end
	end

	def new_hire
		if @cohort = Cohort.find_by(join_token: params[:join_token])
			if @user = User.find_by(email: params[:user][:email]) 
			  if @user.update_attributes(new_user_params)	
					@user.cohorts << @cohort
		      cookies[:auth_token] = @user.auth_token
					redirect_to dashboard_path(@user)
				else
					@error = "Hmm, that's not right. Please be sure to use the email address at which you received the email. You will be able to change it later."
					render 'new_hire_join'
				end
			else
				@error = "Hmm, that's not right. Please be sure to use the email address at which you received the email. You will be able to change it later."
				render 'new_hire_join'
			end
		else
			redirect_to :root
		end
	end

	private

	def new_user_params
		params.require(:user).permit(:first_name, :last_name, :email, :phone, :photo, :password, :password_confirmation)
	end

end