class Users::RequestsController < ApplicationController

	before_action :authenticate_user!, except: :index
	before_action :is_banned
	before_action :cannot_change, only: [:edit, :update, :destroy]

	def index
		@requests = Request.page(params[:page]).per(10)
	end

	def new
		@request = Request.new
	end

	def create
		@request = current_user.requests.new(request_params)
		if current_user.ticket >= params[:request][:capacity].to_i
			if @request.save
				current_user.update(ticket: current_user.ticket - params[:request][:capacity].to_i)
				redirect_to users_requests_path
			else
				render :new
			end
		else
			redirect_to new_users_request_path, flash: { error: "助っ人チケットが不足しています" }
		end
	end

	def show
		@request = Request.find(params[:id])
		@participants = @request.participants.all
		@participant = Participant.find_by(request_id: @request.id,
										   user_id: current_user.id)
	end

	def edit
	end

	def update
		difference = params[:request][:capacity].to_i - @request.capacity
		if current_user.ticket >= difference
			if @request.update(request_params)
				current_user.update(ticket: current_user.ticket - difference)
				redirect_to users_request_path(@request), flash: { notice: "依頼内容を更新しました。" }
			else
				render :edit
			end
		else
			redirect_to edit_users_request_path(@request), flash: { error: "チケットが不足しています。" }
		end
	end

	def destroy
		@request.ticket_return_destroy(@request)
		@request.destroy
		redirect_to users_customer_path(current_user), flash: { error: "依頼を削除し、募集人数分のチケットが返還されました。" }
	end

	private

	def request_params
		params.require(:request).permit(:datetime, :address, :title, :content, :capacity, :image, :deadline)
	end

	def cannot_change
		@request = Request.find(params[:id])
		if @request.user == current_user
			if DateTime.now >= @request.datetime
				redirect_to users_request_path(@request), flash: { error: "依頼が終了しているため変更できません。" }
			end
		else
			redirect_to users_request_path(@request), flash: { error: "依頼者以外は変更できません。" }
		end
	end

end
