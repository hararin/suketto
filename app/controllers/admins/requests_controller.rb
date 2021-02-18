class Admins::RequestsController < ApplicationController

	def index
		@requests = Request.all
	end

	def show
		@request = Request.find(params[:id])
		@participants = @request.participants.all
	end
end
