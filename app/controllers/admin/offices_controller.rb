class Admin::OfficesController < AdminController

	def create
		@office = Office.new(new_office_params)
		@company = Company.find(params[:company_id])
		@office.company = @company
		if @office.save
			OfficeMailer.new_office_signup(@office).deliver
			redirect_to admin_company_path(@company)
		else
			render 'admin/companies/show'
		end
	end

	private

	def new_office_params
		params.require(:office).permit(:phone, :street_address, :zip_code, :state_abbr, :contact_email, :city)
	end

end