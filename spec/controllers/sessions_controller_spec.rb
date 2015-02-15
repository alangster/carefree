require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do 

	describe 'GET new' do 
		it 'instantiates a new user' do 
			get :new
			expect(assigns(:user)).to be_a_new(User)
		end
	end

	describe 'POST create' do
		describe 'successful login' do  
			before(:each) do 
				@user = build(:user, id: 1)
				allow(@user).to receive(:authenticate).and_return(true)
				allow(User).to receive(:find_by).and_return(@user)
			end

			it 'sets the user_id session key' do 
				post :create, user: attributes_for(:user)
				expect(session[:user_id]).to eq(1)
			end

			context 'non-admin user' do 
				it 'redirects to generic dashboard' do 
					post :create, user: attributes_for(:user)
					expect(response).to redirect_to(dashboard_path(@user))
				end
			end

			context 'admin user' do 
				it 'redirects to admin dashboard' do 
					allow(@user).to receive(:admin?).and_return(true)
					post :create, user: attributes_for(:user)
					expect(response).to redirect_to(admin_dashboard_path)
				end
			end
		end

		describe 'unsucessful login' do 
			describe 'incorrect password' do 
				before(:each) do 
					@user = build(:user, id: 1)
					allow(@user).to receive(:authenticate).and_return(false)
					allow(User).to receive(:find_by).and_return(@user)
				end

				it 'assigns an error' do 
					post :create, user: attributes_for(:user)
					expect(assigns(:error)).not_to be_nil
				end

				it 're-renders the login form' do 
					post :create, user: attributes_for(:user)
					expect(response).to render_template('sessions/new')
				end
			end

			describe 'no such user' do 
				before(:each) do 
					allow(User).to receive(:find_by).and_return(nil)
				end

				it 'assigns an error' do 
					post :create, user: attributes_for(:user)
					expect(assigns(:error)).not_to be_nil
				end

				it 're-renders the login form' do 
					post :create, user: attributes_for(:user)
					expect(response).to render_template('sessions/new')
				end
			end
		end
	end

end