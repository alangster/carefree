class Office < ActiveRecord::Base

	include TokenGenerator

	belongs_to :company
	has_many :employees, class: 'User'

	has_many :cohorts

	has_many :employee_addresses

	has_many :office_vendors
	has_many :vendors, through: :office_vendors

	validates :contact_email, presence: true

	before_create { generate_token(:join_token) }

end
