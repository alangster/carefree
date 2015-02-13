require 'rails_helper'

RSpec.describe User, :type => :model do

	after(:all) do 
		DatabaseCleaner.clean
	end

	describe 'token generation' do 
		it 'should generate a password_reset token on creation' do
			user = build(:user)
			expect(user.password_reset_token).to be_nil
			user.save!
			expect(user.password_reset_token).not_to be_nil
		end
	end

	describe 'office validation' do 
		context 'user without office' do 

			context 'non admin user' do 
				it 'should not be valid' do
					user = build(:user, office_id: nil)
					expect(user).not_to be_valid
				end
			end

			context 'admin user' do 
				it 'should be valid' do 
					admin = build(:admin)
					expect(admin).to be_valid
				end
			end

		end
	end

end
