class Users::CustomersController < ApplicationController

	before_action :authenticate_user!
	before_action :is_banned, only:[:edit, :update]

	def show
		@user = User.find(params[:id])
		@participants = @user.participants.page(params[:page]).per(5)
		@requests = @user.requests.page(params[:page]).per(5)
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update(user_params)
			redirect_to users_customer_path(current_user)
		else
			redirect_to edit_users_customer_path(@user), flash: { error: "ユーザー情報を入力してください。" }
		end
	end

	def destroy
		
	end

	private
	def user_params
		params.require(:user).permit(:name, :age, :sex, :image, :introduction)
	end
end
