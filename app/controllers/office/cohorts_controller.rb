class Office::CohortsController < OfficesController

	before_action :require_hr, except: [:index, :show]
	before_action :require_supervisor, only: [:index]

	def index
		@cohorts = current_user.cohorts.order(:created_at) 
	end

	def new
	end

	def show
		@cohort = Cohort.includes(:members).find_by(id: params[:id])
		if user_is_hr
			# get everything needed for hr rep (add an include to the cohort finding)
			# render template allowing hr rep to add people 
			# to cohort, change name, and destroy (if necessary)

			# for the initial development hr needs to:
			# => see everyone already in the cohort
			# => invite people to the cohort
			# => => invite managers to the cohort
			# => => => if managers not in the system, invite via email
			# => => => else, search people in the system
			# => => invite new hires to the cohort via email
			# => change cohort name
			# => delete cohort (confirm before completing)



			# later on, hr needs to:
			# => add tasks to every new hire's checklist
			# => add tasks to specific new hire's checklist
			# => add tasks to every manager's checklist
			# => add tasts to specific manager's checklist
			render 'hr_cohort'
		else
			# get basic cohort info (add an include to the cohort finding)
			# render template showing cohort info and members
		end
	end

	def create
		cohort = Cohort.new(name: params[:name], office: current_user.office)
		if cohort.save
			redirect_to cohort_path(cohort) 
		else
			render :new
		end
	end

	def new_hires
		role_id = Role.find_by(name: 'New Hire').id
		User.add_new(users: params[:emails].strip, role: role_id, cohort: Cohort.find(params[:id]).join_token)
		head 200, content_type: 'text/html'
	end

	private

	def require_hr
		redirect_to dashboard_path(current_user) unless user_is_hr
	end

	def require_supervisor
		user_is_hr || user.role.name == 'Manager'
	end

	def user_is_hr
		current_user.role.name == 'HR'
	end

end