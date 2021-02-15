class Users::RequestsController < ApplicationController

	def index
		@requests = Request.all
	end

	def new
		@request = Request.new
	end

	def create
		@request = current_user.requests.new(request_params)
		if @request.save
			redirect_to users_requests_path
		else
			render :new
		end
	end

	def show
		@request = Request.find(params[:id])
		@participants = @request.participants.all
		@participant = Participant.find_by(request_id: @request.id,
										   user_id: current_user.id)
	end

	def edit
		@request = Request.find(params[:id])
	end

	def update
		@request = Request.find(params[:id])
		if @request.update(request_params)
			redirect_to users_request_path(@request)
		else
			render :edit
		end
	end

	def destroy
		@request = Request.find(params[:id])
		@request.destroy
		redirect_to users_requests_path
	end

	private

	def request_params
		params.require(:request).permit(:event, :datetime, :address, :title, :content, :capacity)
	end
end
