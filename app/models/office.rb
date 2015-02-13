class Office < ActiveRecord::Base

	belongs_to :company
	has_many :employees, class: 'User'

	has_many :cohorts

	has_many :employee_addresses

	has_many :office_vendors
	has_many :vendors, through: :office_vendors

end
