class Admins::RequestsController < ApplicationController

	before_action :authenticate_admin!

	def index
		@requests = Request.page(params[:page]).per(5)
	end

	def show
		@request = Request.find(params[:id])
		@participants = @request.participants.all
	end
end
