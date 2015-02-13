class Admin::CompaniesController < AdminController

	def index
		@company = Company.new
		@companies = Company.includes(:offices).all
	end

	def create
		
	end

end