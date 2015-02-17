class Cohort < ActiveRecord::Base

	include TokenGenerator

	has_many :cohort_members
	has_many :members, through: :cohort_members, source: :user

	belongs_to :office

	has_one :budget, as: :budgetable

	validates :office_id, presence: true

	before_create { generate_token(:join_token) }

end
