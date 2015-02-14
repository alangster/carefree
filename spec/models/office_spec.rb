require 'rails_helper'

RSpec.describe Office, :type => :model do

	after(:all) do 
		DatabaseCleaner.clean
	end

	describe 'token generator' do
		context 'on creation' do  
			it 'generates a join_token' do 
				office = build(:office)
				expect(office.join_token).to be_nil
				office.save!
				expect(office.join_token).not_to be_nil
				office.destroy
			end
		end
	end

end
