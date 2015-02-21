class User < ActiveRecord::Base

	include TokenGenerator

	has_many :cohort_members
	has_many :cohorts, through: :cohort_members

	belongs_to :office 

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
	before_create { generate_token(:auth_token) }

	class << self

		def search(args)
			if args[:query] && args[:office_id]
				where('office_id = :office_id AND last_name LIKE :query', args.update({ query: "%#{args[:query]}%" }))			
			end
		end

		def add_new(args)
			args[:users].split(/[\s;,]+/).map do |email|
				user = find_or_initialize_by(email: email)
				user.role_id = args[:role]
				user.save(validate: false)
				user
			end.each {|inv_user| inv_user.send_cohort_join(args[:cohort])}
		end

	end

	def send_cohort_join(token)
		UserMailer.cohort_join(self, token).deliver unless self.password 
	end

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def name
		"#{first_name} #{last_name}"
	end

	def supervisor?
		self.role ? (self.role.name == 'HR' || self.role.name == 'Manager') : false
	end

end
