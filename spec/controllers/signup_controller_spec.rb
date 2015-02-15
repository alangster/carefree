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

end
