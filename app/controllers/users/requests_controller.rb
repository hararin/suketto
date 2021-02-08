class Users::RequestsController < ApplicationController

	def index
		@requests = Request.all
	end

	def new
		@request = Request.new
	end

	def create
		@request = current_user.requests.new(request_params)
		@request.save
	end

	def show
		
	end

	def edit
		
	end

	def update
		
	end

	def destroy
		
	end
end
