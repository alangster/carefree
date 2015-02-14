require 'rails_helper'

RSpec.describe Admin::CompaniesController, :type => :controller do 

	before(:each) do
		allow(controller).to receive(:require_login).and_return(true)
		allow(controller).to receive(:require_admin).and_return(true) 
	end

	after(:all) do 
		DatabaseCleaner.clean 
		ActionMailer::Base.deliveries.clear
	end



end