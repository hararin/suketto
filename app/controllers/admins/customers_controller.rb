class Admins::CustomersController < ApplicationController

	before_action :authenticate_admin!

	def index
		@users = User.page(params[:page]).per(10)
	end

	def show
		@user = User.find(params[:id])
		@participants = @user.participants.page(params[:page]).per(5)
		@requests = @user.requests.page(params[:page]).per(5)
		@purchases = @user.purchases.page(params[:page]).per(5)
	end

	def ban
		@user = User.find(params[:id])
		any_requests_or_participants?(@user)
		if @req_in_progress.blank? == false
			@req_in_progress.each do |request|
				request.ticket_return_ban(request)
				request.destroy
			end
		end
		if @par_in_progress.blank? == false
			@par_in_progress.each do |participant|
				participant.user.update(ticket: participant.user.ticket - 1)
				participant.destroy
			end
		end
		@user.update(is_banned: true)
		redirect_to admins_customer_path(@user)
	end

	def unban
		@user = User.find(params[:id])
		@user.update(is_banned: false)
		redirect_to admins_customer_path(@user)
	end

end
