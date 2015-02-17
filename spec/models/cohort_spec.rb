require 'rails_helper'

RSpec.describe Cohort, :type => :model do

	describe 'token generation' do 
		it 'generates a token on creation' do 
			cohort = build(:cohort)
			expect(cohort.join_token).to be_nil
			cohort.save
			expect(cohort.join_token).not_to be_nil
			Cohort.last.destroy
		end
	end

end
