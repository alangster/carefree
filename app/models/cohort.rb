class Cohort < ActiveRecord::Base

	has_many :cohort_members
	has_many :members, through: :cohort_members, source: :user

	belongs_to :office

	has_one :budget, as: :budgetable

end
