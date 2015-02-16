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
				session[:user_id] = @user.id
				redirect_to dashboard_path(@user)
			else
				render 'new_office'
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