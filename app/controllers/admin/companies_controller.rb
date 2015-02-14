class Admin::CompaniesController < AdminController

	def index
		@company = Company.new
		@companies = Company.all
	end

	def create
		@company = Company.new(new_company_attributes)
		if @company.save
			redirect_to admin_company_path(@company)
		else
			@error = "Could not add company"
			render :new
		end
	end

	def new
		@company = Company.new
	end

	def show
		@company = Company.includes(:offices).find(params[:id])
		@office = Office.new
	end

	def lock
		if company = Company.find_by(id: params[:id])
			company.toggle!(:locked) 
			render nothing: true, status: 200
		else
			render nothing: true, status: 500
		end
	end

	private

	def new_company_attributes
		params.require(:company).permit(:name)
	end

end