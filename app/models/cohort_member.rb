class CohortMember < ActiveRecord::Base

	belongs_to :cohort
	belongs_to :user
	
end
