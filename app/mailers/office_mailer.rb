class OfficeMailer < ActionMailer::Base

  def new_office_signup(office)
  	@office = office
  	mail(to: office.contact_email, subject: 'Join Carefree', from: 'welcome@carefree.lv')
  end

end
