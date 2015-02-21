require "rails_helper"

RSpec.describe OfficeMailer, :type => :mailer do

	before(:each) do 
		ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
	end

	after(:each) do 
		ActionMailer::Base.deliveries.clear
	end

	describe 'new_office_signup' do 
		# let(:office) {build(:office, email: 'hr@company.com')}
		# let(:mail)   {OfficeMailer.new_office_signup(office)}


	end

end
