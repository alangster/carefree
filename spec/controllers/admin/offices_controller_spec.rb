require 'rails_helper'

RSpec.describe Admin::OfficesController, :type => :controller do 

	before(:each) do
		allow(controller).to receive(:require_login).and_return(true)
		allow(controller).to receive(:require_admin).and_return(true) 
		allow(Company).to receive(:find).and_return(build(:company))
		ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
	end

	after(:each) do 
		ActionMailer::Base.deliveries.clear
	end

	describe 'POST new office' do 

		context 'valid office params' do 
			it 'sends a join email' do 
				expect(ActionMailer::Base.deliveries.size).to eq(0)
				post 'create', {office: attributes_for(:office), company_id: 1}
				expect(ActionMailer::Base.deliveries.size).to eq(1)
			end
		end

		context 'invalid office params' do 
			context 'no contact_email' do 
				
				it 'does not send a join email' do 
					expect(ActionMailer::Base.deliveries.size).to eq(0)
					post 'create', {office: attributes_for(:office, contact_email: ''), company_id: 1}
					expect(ActionMailer::Base.deliveries.size).to eq(0)
				end

				it 'renders the correct template' do 
					post 'create', {office: attributes_for(:office, contact_email: ''), company_id: 1}
					expect(response).to render_template('admin/companies/show')
				end
			end
		end

	end

end