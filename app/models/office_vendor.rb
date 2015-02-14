class OfficeVendor < ActiveRecord::Base

	belongs_to :office
	belongs_to :vendor

end
