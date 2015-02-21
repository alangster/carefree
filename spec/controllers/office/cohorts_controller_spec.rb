require 'rails_helper'

RSpec.describe Office::CohortsController, :type => :controller do 

	before(:each) do 
		allow(controller).to receive(:require_login).and_return(true)
		allow(controller).to receive(:valid_office).and_return(true)
	end

	describe 'POST create' do 
		before(:each) do 
			allow(controller).to receive(:require_hr).and_return(true)
			@user = build(:user)
			allow(controller).to receive(:current_user).and_return(@user)
			@new_cohort = build(:cohort, id: 1)
			allow(Cohort).to receive(:new).and_return(@new_cohort)
		end

		describe 'successful save' do
			it 'redirects to newly-created cohort' do 
				allow(@new_cohort).to receive(:save).and_return(true)
				post :create, name: 'Mudpuppies'
				expect(response).to be_redirect
			end

			it 'makes current_user cohort member' do 
				expect(@user).to receive(:cohorts).and_return([])
				post :create, name: 'Mudpuppies'
			end
		end

		describe 'unsuccessful save' do 
			it 're-renders the form' do 
				allow(@new_cohort).to receive(:save).and_return(false)
				post :create, name: 'Mudpuppies'
				expect(response).to render_template('office/cohorts/new')
			end
		end
	end

	describe 'GET show' do 
		describe 'user is hr rep' do 
			before(:each) do 
				allow(controller).to receive(:user_is_hr).and_return(true)
				allow(Cohort).to receive(:includes).and_return(Cohort)
				allow(Cohort).to receive(:find_by).and_return(build(:cohort))
			end

			it 'renders the hr-specific template' do 
				get :show, id: 1
				expect(response).to render_template('hr_cohort')
			end
		end
	end

	describe 'POST new_hires' do 
		before(:each) do 
			allow(controller).to receive(:user_is_hr).and_return(true)
			allow(User).to receive(:add_new).and_return(true)
			allow(Cohort).to receive(:find).and_return(build(:cohort, join_token: 'token'))
			allow(Role).to receive(:find_by).and_return(build(:role, id: 1))
			users = Array.new(4) { build(:user) }
			@params = {emails: users.map(&:email).join(' '), id: 2}
		end

		it 'calls User.add_new' do 
			expect(User).to receive(:add_new).and_return(true)
			post :new_hires, @params
		end

		it 'sends 200 status code' do 
			post :new_hires, @params
			expect(response).to have_http_status(200)
		end
	end

end