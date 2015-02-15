require 'rails_helper'

RSpec.describe SignupController, :type => :controller do 

	describe 'GET new_office' do 
		before(:each) do
			@office = build(:office) 
			allow(Office).to receive(:find_by).and_return(@office)
		end

		context 'valid office token' do 
			it 'builds a new user' do 
				get :new_office, office_join_token: 'token'
				expect(assigns(:user)).to be_a_new(User)
			end

			it 'assigns the office' do 
				get :new_office, office_join_token: 'token'
				expect(assigns(:office)).to eq(@office)
			end
		end

		context 'invalid office token' do 
			it 'redirects to the root' do 
				allow(Office).to receive(:find_by).and_return(nil)
				get :new_office, office_join_token: 'not_token'
				expect(response).to redirect_to(root_url)
			end
		end
	end

	describe 'POST office_contact' do 
		
		describe 'valid office' do 
			before(:each) do 
				@office = build(:office, id: 1)
				allow(Office).to receive(:find_by).and_return(@office)
				allow(Role).to receive(:find_by).and_return(build(:role, name: 'HR'))
			end

			context 'successful save' do 
				it 'sets new user role and office' do 
					post :office_contact, { user: attributes_for(:new_user), office_id: 1 }
					expect(assigns(:user).office_id).to eq(1)
					expect(assigns(:user).role.name).to eq('HR')
					User.last.destroy
				end

				it 'sets the current user' do
					post :office_contact, { user: attributes_for(:new_user), office_id: 1 }
					expect(session[:user_id]).not_to be_nil
					User.last.destroy
				end

				it 'redirects to user dashboard' do 
					post :office_contact, { user: attributes_for(:new_user), office_id: 1 }
					new_user = assigns(:user)
					expect(response).to redirect_to(dashboard_path(new_user))
					User.last.destroy
				end
			end

			context 'unsucessful save' do 
				it 're-renders the signup form' do
					post :office_contact, { user: attributes_for(:new_user, email: ''), office_id: 1 }
					expect(response).to render_template('signup/new_office')
				end
			end
		end

		describe 'invalid office' do 
			before(:each) do 
				allow(Office).to receive(:find_by).and_return(nil)
			end

			it 'redirects to root' do
				post :office_contact, { user: attributes_for(:new_user), office_id: 1 }
				expect(response).to redirect_to(root_path)
			end
		end


	end

end
