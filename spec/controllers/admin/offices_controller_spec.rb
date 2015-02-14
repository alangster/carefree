require 'rails_helper'

RSpec.describe Admin::OfficesController, :type => :controller do 

	after(:all) do 
		DatabaseCleaner.clean 
		ActionMailer::Base.deliveries.clear
	end

	describe 'POST new office' do 
		it 'sends a join email' do 
			expect(ActionMailer::Base.deliveries.size).to eq(0)
			post :create, company_id: 1, office: build_stubbed(:office)
			expect(ActionMailer::Base.deliveries.size).to eq(1)
		end
	end

end