class Conversation < ActiveRecord::Base

	has_many :conversation_members
	has_many :members, through: :converation_members

	has_many :messages

end
