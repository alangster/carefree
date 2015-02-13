class Vendor < ActiveRecord::Base

	has_many :office_vendors
	belongs_to :vendor_category

end
