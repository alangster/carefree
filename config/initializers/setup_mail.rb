ActionMailer::Base.smtp_settings = {
	:address              => 'smtp.gmail.com',
	:port                 => 587,
	:domain               => 'gmail.com',
	:user_name            => 'carefreeliving3',
	:password             => Rails.application.secrets.email_password,
	:authentication       => 'plain',
	:enable_starttls_auto => true
}