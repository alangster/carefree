class Admin::OfficesController < AdminController

	def create
		p "DINGGGG"
		@office = Office.new(new_office_params)
		@company = Company.find(params[:company_id])
		@office.company = @company
		if @office.save!
			p "SAVED"
			OfficeMailer.new_office_signup(@office).deliver
			redirect_to @company
		else
			render 'company/show'
		end
	end

	private

	def new_office_params
		params.require(:office).permit(:phone, :street_address, :zip_code, :state_abbr, :contact_email)
	end

end