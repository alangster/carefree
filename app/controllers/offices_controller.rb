class OfficesController < ApplicationController

	before_action :valid_office

	private

	def valid_office
		redirect_to :root unless current_user.office 
	end

end