class User < ActiveRecord::Base

	has_many :cohort_members
	has_many :cohorts, through: :cohort_members

	has_one :budget, as: :budgetable

	has_many :checklists
	has_many :tasks, through: :checklists
	has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assigner_id'

	belongs_to :role

	has_many :conversation_members, foreign_key: :member_id
	has_many :conversations, through: :conversation_members

	has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'

end
