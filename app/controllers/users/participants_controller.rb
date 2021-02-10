class Users::ParticipantsController < ApplicationController

	def create
		@request = Request.find_by(id: params[:request_id])
		@participant = @request.participants.new
		@participant.user_id = current_user.id
		if @request.capacity > @request.participants.count
			@participant.save
		else
			redirect_to users_request_path(@request)
		end
	end

	def destroy
		@participant = Participant.find_by(request_id: params[:request_id],
										   id: params[:id])
		@participant.destroy
		redirect_to users_requests_path
	end
end
