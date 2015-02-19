class UserMailer < ActionMailer::Base

	default from: 'noreply@carefree.com' 

  def password_reset(user)
    @user = user
    mail(to: user.email, subject: 'Password Reset')
  end

  def cohort_join(user, token)
  	@user = user
  	@token = token
  	mail(to: user.email, subject: 'Join Your New Cohort')
  end

end
