module ApplicationHelper

	def current_user
		@current_user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
	end

	def office_title(office)
		"#{office.company.name}, #{office.city}"
	end

	def user_is_hr
		current_user.role.name == 'HR'
	end

	def us_states
		[
	 		['AK', 'AK'],
	    ['AL', 'AL'],
	    ['AR', 'AR'],
	    ['AZ', 'AZ'],
	    ['CA', 'CA'],
	    ['CO', 'CO'],
	    ['CT', 'CT'],
	    ['DC', 'DC'],
	    ['DE', 'DE'],
	    ['FL', 'FL'],
	    ['GA', 'GA'],
	    ['HI', 'HI'],
	    ['IA', 'IA'],
	    ['ID', 'ID'],
	    ['IL', 'IL'],
	    ['IN', 'IN'],
	    ['KS', 'KS'],
	    ['KY', 'KY'],
	    ['LA', 'LA'],
	    ['MA', 'MA'],
	    ['MD', 'MD'],
	    ['ME', 'ME'],
	    ['MI', 'MI'],
	    ['MN', 'MN'],
	    ['MO', 'MO'],
	    ['MS', 'MS'],
	    ['MT', 'MT'],
	    ['NC', 'NC'],
	    ['ND', 'ND'],
	    ['NE', 'NE'],
	    ['NH', 'NH'],
	    ['NJ', 'NJ'],
	    ['NM', 'NM'],
	    ['NV', 'NV'],
	    ['NY', 'NY'],
	    ['OH', 'OH'],
	    ['OK', 'OK'],
	    ['OR', 'OR'],
	    ['PA', 'PA'],
	    ['RI', 'RI'],
	    ['SC', 'SC'],
	    ['SD', 'SD'],
	    ['TN', 'TN'],
	    ['TX', 'TX'],
	    ['UT', 'UT'],
	    ['VA', 'VA'],
	    ['VT', 'VT'],
	    ['WA', 'WA'],
	    ['WI', 'WI'],
	    ['WV', 'WV'],
	    ['WY', 'WY']
  	]
	end

end
