class Admins::CustomersController < ApplicationController

	def index
		@users = User.page(params[:page]).per(5)
	end

	def show
		@user = User.find(params[:id])
		@participants = @user.participants.all
		@requests = @user.requests.all
	end

end
