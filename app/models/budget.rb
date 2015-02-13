class Budget < ActiveRecord::Base

	belongs_to :budgetable, polymorphic: true
	has_many :expenses

end
