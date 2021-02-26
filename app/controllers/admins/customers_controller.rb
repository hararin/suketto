class Admins::CustomersController < ApplicationController

	def index
		@users = User.page(params[:page]).per(10)
	end

	def show
		@user = User.find(params[:id])
		@participants = @user.participants.page(params[:page]).per(5)
		@requests = @user.requests.page(params[:page]).per(5)
		@purchases = @user.purchases.page(params[:page]).per(5)
	end

end
