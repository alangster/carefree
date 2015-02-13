class ConversationMember < ActiveRecord::Base

	belongs_to :member, class_name: 'User'
	belongs_to :conversation

end
