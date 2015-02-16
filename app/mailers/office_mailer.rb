class OfficeMailer < ActionMailer::Base

  def new_office_signup(office)
  	@office = office
  	@url = root_url + "signup/office/#{office.join_token}"
  	mail(to: office.contact_email, subject: 'Join Carefree', from: 'welcome@carefree.com')
  end

end
