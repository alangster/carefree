class Office::CohortsController < OfficesController

	before_action :require_hr, except: [:index, :show]

	def new
	end

	def index
	end

	def show
	end

	private

	def require_hr
		redirect_to dashboard_path(current_user) unless current_user.role.name == 'HR'
	end

end