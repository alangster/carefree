class Task < ActiveRecord::Base

	belongs_to :checklist
	belongs_to :assigner, class_name: 'User'
	
end
