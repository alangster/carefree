class PasswordResetsController < ApplicationController
  
	skip_before_action :require_login

  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	user.send_password_reset if user 
  	redirect_to new_login_path, notice: 'Email sent with password reset instructions.'
  end

  def edit
  	@user = User.find_by!(password_reset_token: params[:id])
  end

  def update
  	@user = User.find_by!(password_reset_token: params[:id])
  	if @user.password_reset_sent_at < 2.hours.ago
  		redirect_to password_reset_path, alert: 'Password reset has expired'
  	elsif @user.update_attributes(password: params[:user])
  		cookies[:auth_token] = @user.auth_token
  		redirect_to dashboard_path(@user)
		else
			render :edit
  	end
  end

end
