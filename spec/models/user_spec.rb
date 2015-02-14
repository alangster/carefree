require 'rails_helper'

RSpec.describe User, :type => :model do

	after(:all) do 
		DatabaseCleaner.clean
	end

	describe 'token generator' do 
		context 'on creation' do 
			it 'generates a password_reset token' do
				user = build(:user)
				expect(user.password_reset_token).to be_nil
				user.save!
				expect(user.password_reset_token).not_to be_nil
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

end
