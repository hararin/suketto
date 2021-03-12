class Users::CustomersController < ApplicationController

	before_action :authenticate_user!
	before_action :is_banned, only:[:edit, :update]

	def show
		@user = User.find(params[:id])
		@participants = @user.participants.page(params[:page]).per(5)
		@requests = @user.requests.page(params[:page]).per(5)
		@requests.each do |request|
			request.ticket_return(request)
		end
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

	def withdraw
		@user = current_user
		any_requests_or_participants?(@user)
		if @req_in_progress.blank? == false
	    	redirect_to users_customer_path(@user), flash: { error: "進行中の依頼があるため退会できません。" }
	    	return
	    elsif @par_in_progress.blank? == false
	    	redirect_to users_customer_path(@user), flash: { error: "進行中の助っ人があるため退会できません。" }
	    	return
	    else
		    @user.discard
			reset_session
			redirect_to '/'
	    end
	end

	private
	def user_params
		params.require(:user).permit(:name, :age, :sex, :image, :introduction)
	end
end
