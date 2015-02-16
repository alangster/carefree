require 'rails_helper'

RSpec.describe User, :type => :model do

	describe 'token generator' do 
		context 'on creation' do 
			it 'generates a password_reset token' do
				user = build(:user)
				expect(user.password_reset_token).to be_nil
				user.save!
				expect(user.password_reset_token).not_to be_nil
				user.destroy
			end

			it 'generates an auth_token' do 
				user = build(:user)
				expect(user.auth_token).to be_nil
				user.save!
				expect(user.auth_token).not_to be_nil
				user.destroy
			end
		end
	end

	describe 'office validation' do 
		context 'user without office' do 
			context 'non admin user' do 
				it 'is not valid' do
					user = build(:user, office_id: nil)
					expect(user).not_to be_valid
				end
			end

			context 'admin user' do 
				it 'is valid' do 
					admin = build(:admin)
					expect(admin).to be_valid
				end
			end
		end
	end

	describe '#send_password_reset' do 
		before(:each) do 
			ActionMailer::Base.delivery_method = :test
	    ActionMailer::Base.perform_deliveries = true
	    ActionMailer::Base.deliveries = []
	    @user = build(:user, password_reset_token: 'token')
	    allow(@user).to receive(:save!).and_return(true)
		end

		it 'generates a new password_reset_token' do 
			expect(@user.password_reset_token).to eq('token')
			@user.send_password_reset
			expect(@user.password_reset_token).not_to eq('token')
			expect(@user.password_reset_token).not_to be_nil
		end

		it 'sets the password_reset_sent_at' do 
			@user.send_password_reset
			expect(@user.password_reset_sent_at).to be_a(Time)
		end

		it 'sends the email' do 
			@user.send_password_reset
			expect(ActionMailer::Base.deliveries.count).to eq(1)
		end

	end

end
