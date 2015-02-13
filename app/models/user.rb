class User < ActiveRecord::Base

	include TokenGenerator

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

	has_secure_password

	validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
	validates :password, confirmation: true
	validates :office_id, presence: true, unless: Proc.new { |u| u.admin? }
	validates :email, uniqueness: true

	before_create { generate_token(:password_reset_token) }

end
