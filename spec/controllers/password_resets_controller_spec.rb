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
  			allow(@user).to receive(:send_password_reset).and_return(true)
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

  describe 'GET edit' do 
  	describe 'legitimate user' do
  		before(:each) do 
  			allow(User).to receive(:find_by!).and_return(build(:user))
  		end

  		it 'instantiates the user' do 
  			get :edit, id: 'dfghj'
  			expect(assigns(:user)).to be_a(User)
  		end
  	end

  	describe 'illegitimate user' do 
  		before(:each) do
  			allow(User).to receive(:find_by!).and_raise(ActiveRecord::RecordNotFound)
  		end

  		# it 'responds with a 404' do 
  		# 	get :edit, id: 'gfzw'
  		# 	expect(response).to have_http_status(404)
  		# end
  	end
  end

  describe 'PUT update' do 
  	describe 'legitimate user' do 
  		before(:each) do 
  			@user = build(:user)
  			allow(User).to receive(:find_by!).and_return(@user)
  		end

  		describe 'expired password reset token' do 
  			before(:each) do 
  				allow(@user).to receive(:password_reset_sent_at).and_return(Time.now - (121 * 60))
  			end

  			it 'redirects to password reset path' do 
  				put :update, {id: 'token', password: 'boom', password_confirmation: 'boom'}
  				expect(response).to redirect_to(password_reset_path)
  				expect(flash[:alert]).not_to be_nil
  			end
  		end

  		describe 'valid password reset token' do
  			before(:each) do 
  				allow(@user).to receive(:password_reset_sent_at).and_return(Time.now - 60)
  			end 
  			
  			describe 'successful password update' do
  				before(:each) do 
  					allow(@user).to receive(:update_attributes).and_return(true)
  					allow(@user).to receive(:auth_token).and_return('auth')
  				end

  				it 'sets the cookie' do 
  					put :update, {id: 'token', password: 'boom', password_confirmation: 'boom'}
  					expect(cookies[:auth_token]).to eq('auth')
  				end

  				it 'redirects to dashboard' do 
  					put :update, {id: 'token', password: 'boom', password_confirmation: 'boom'}
  					expect(response).to redirect_to(dashboard_path(@user))
  				end
  			end

  			describe 'unsucessful password reset' do 
  				before(:each) do 
  					allow(@user).to receive(:update_attributes).and_return(false)
  				end

  				it 'does not set the cookie' do 
  					put :update, {id: 'token', password: 'boom', password_confirmation: 'boom'}
  					expect(cookies[:auth_token]).to be_nil
  				end

  				it 're-renders the form' do 
  					put :update, {id: 'token', password: 'boom', password_confirmation: 'boom'}
  					expect(response).to render_template('password_resets/edit')
  				end
  			end
  		end
  	end
  end
end
