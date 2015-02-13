class SessionsController < ApplicationController

	skip_before_action :require_login, except: [:destroy]



end