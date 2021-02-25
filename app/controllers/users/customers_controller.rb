class Users::CustomersController < ApplicationController

	before_action :authenticate_user!

	def index
		@user = Users.all
	end

	def show
		@user = User.find(params[:id])
		@participants = @user.participants.all
		@requests = @user.requests.all
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update(user_params)
			redirect_to users_customer_path(current_user)
		else
			render :edit
		end
	end

	def destroy
		
	end

	private
	def user_params
		params.require(:user).permit(:name, :age, :sex, :image)
	end
end
