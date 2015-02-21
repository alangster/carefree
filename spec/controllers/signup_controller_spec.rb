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
					post :office_contact, { user: attributes_for(:new_user), office_join_token: 'token' }
					expect(assigns(:user).office_id).to eq(1)
					expect(assigns(:user).role.name).to eq('HR')
					User.last.destroy
				end

				it 'sets the current user' do
					post :office_contact, { user: attributes_for(:new_user), office_join_token: 'token' }
					expect(cookies[:auth_token]).not_to be_nil
					User.last.destroy
				end

				it 'redirects to user dashboard' do 
					post :office_contact, { user: attributes_for(:new_user), office_join_token: 'token' }
					new_user = assigns(:user)
					expect(response).to redirect_to(dashboard_path(new_user))
					User.last.destroy
				end
			end

			context 'unsucessful save' do 
				it 're-renders the signup form' do
					post :office_contact, { user: attributes_for(:new_user, email: ''), office_join_token: 'token' }
					expect(response).to render_template('signup/new_office')
				end
			end
		end

		describe 'invalid office' do 
			before(:each) do 
				allow(Office).to receive(:find_by).and_return(nil)
			end

			it 'redirects to root' do
				post :office_contact, { user: attributes_for(:new_user), office_join_token: 'token' }
				expect(response).to redirect_to(root_path)
			end
		end
	end

	describe 'GET new_hire_join' do 
		describe 'with a valid cohort' do 
			before(:each) do 
				@cohort = build(:cohort)
				allow(Cohort).to receive(:includes).and_return(Cohort)
				allow(Cohort).to receive(:find_by).and_return(@cohort)
			end

			it 'instantiates a new user' do 
				get :new_hire_join, join_token: 'token'
				expect(assigns(:user)).to be_a_new(User)
			end

			it 'renders the signup form' do 
				get :new_hire_join, join_token: 'token'
				expect(response).to render_template('signup/new_hire_join')
			end
		end

		describe 'with an invalid cohort' do 
			before(:each) do 
				allow(Cohort).to receive(:includes).and_return(Cohort)
				allow(Cohort).to receive(:find_by).and_return(nil)
			end

			it 'redirects to root' do 
				get :new_hire_join, join_token: 'token'
				expect(response).to redirect_to(root_path)
			end
		end
	end

	describe 'POST new_hire' do 
		describe 'with an invalid cohort' do 
			before(:each) do 
				allow(Cohort).to receive(:find_by).and_return(nil)
			end

			it 'redirects to the root' do 
				post :new_hire, { join_token: 'token', user: attributes_for(:user) }
				expect(response).to redirect_to(root_path)
			end
		end

		describe 'with a valid cohort' do 
			before(:each) do 
				@cohort = build(:cohort, name: 'Mudpuppies')
				allow(Cohort).to receive(:find_by).and_return(@cohort)
			end

			describe 'user not already in database' do 
				before(:each) do 
					allow(User).to receive(:find_by).and_return(nil)
				end

				it 'assigns an error' do 
					post :new_hire, { join_token: 'token', user: attributes_for(:user) }
					expect(assigns(:error)).not_to be_nil
				end

				it 're-renders the form' do 
					post :new_hire, { join_token: 'token', user: attributes_for(:user) }
					expect(response).to render_template('signup/new_hire_join')
				end
			end

			describe 'user attributes do not update' do 
				before(:each) do 
					@user = build(:user)
					allow(User).to receive(:find_by).and_return(@user)
					allow(@user).to receive(:update_attributes).and_return(false)
				end

				it 'assigns an error' do 
					post :new_hire, { join_token: 'token', user: attributes_for(:user) }
					expect(assigns(:error)).not_to be_nil
				end

				it 're-renders the form' do 
					post :new_hire, { join_token: 'token', user: attributes_for(:user) }
					expect(response).to render_template('signup/new_hire_join')
				end
			end

			describe 'user attributes successfully update' do 
				before(:each) do 
					@user = build(:user)
					allow(User).to receive(:find_by).and_return(@user)
					allow(@user).to receive(:update_attributes).and_return(true)
				end

				it 'makes the user a member of the cohort' do 
					post :new_hire, { join_token: 'token', user: attributes_for(:user) }
					expect(@user.cohorts.first.name).to eq('Mudpuppies')
				end

				it 'sets the cookie' do 
					allow(@user).to receive(:auth_token).and_return('token')
					post :new_hire, { join_token: 'token', user: attributes_for(:user) }
					expect(cookies[:auth_token]).to eq('token')
				end

				it 'redirects to the user dashboard' do 
					post :new_hire, { join_token: 'token', user: attributes_for(:user) }
					expect(response).to redirect_to(dashboard_path(@user))
				end
			end
		end
	end

end
