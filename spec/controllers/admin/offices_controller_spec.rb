require 'rails_helper'

RSpec.describe Admin::OfficesController, :type => :controller do 

	before(:each) do
		allow(controller).to receive(:require_login).and_return(true)
		allow(controller).to receive(:require_admin).and_return(true) 
		allow(Company).to receive(:find).and_return(build(:company))
	end

	after(:all) do 
		DatabaseCleaner.clean 
		ActionMailer::Base.deliveries.clear
	end

	describe 'POST new office' do 
		it 'sends a join email' do 
			expect(ActionMailer::Base.deliveries.size).to eq(0)
			post 'create', {office: attributes_for(:office), company_id: 1}
			expect(ActionMailer::Base.deliveries.size).to eq(1)
		end
	end

end