require 'rails_helper'

RSpec.describe PasswordResetsController, :type => :controller do

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do 
  	describe 'legitimate user' do 
  		before(:each) do 
  			@user = build(:user)
  			allow(User).to receive(:find_by).and_return(@user)
  		end

  		it 'sends the password reset' do 
  			expect(@user).to receive(:send_password_reset)
  			post :create, email: 'email@email.com'
  		end

  		it 'redirects to login with message' do 
  			post :create, email: 'email@email.com'
  			expect(response).to redirect_to(new_login_path)
  			expect(flash[:notice]).not_to be_nil
  		end
  	end

  	describe 'illegitimate user' do 
  		before(:each) do 
  			allow(User).to receive(:find_by).and_return(nil)
  		end

  		it 'redirects to login with message' do 
  			post :create, email: 'email@email.com'
  			expect(response).to redirect_to(new_login_path)
  			expect(flash[:notice]).not_to be_nil
  		end
  	end
  end

end
