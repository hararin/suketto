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

	def ban
		@user = User.find(params[:id])
		@user.update(is_banned: true)
		redirect_to admins_customer_path(@user)
	end

	def unban
		@user = User.find(params[:id])
		@user.update(is_banned: false)
		redirect_to admins_customer_path(@user)
	end

end
