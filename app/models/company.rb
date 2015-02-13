class Company < ActiveRecord::Base

	has_many :offices
	has_many :employees, through: :offices

end
