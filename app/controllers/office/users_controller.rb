class Office::UsersController < OfficesController

	def show
	end

	def dashboard
	end

	def search
		@users = User.search(office_id: current_user.office_id, query: params[:query])
		render json: @users
	end

end