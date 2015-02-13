class Admin::CompaniesController < AdminController

	def index
		@company = Company.new
		@companies = Company.all
	end

	def create
		@company = Company.new(new_company_attributes)
		if @company.save
			redirect_to index, notice: "#{@company.name} saved!"
		else
			@error = "Could not add company"
			render :index
		end
	end

	private

	def new_company_attributes
		params.require(:company).permit(:name)
	end

end