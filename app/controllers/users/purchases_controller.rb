class Users::PurchasesController < ApplicationController

	before_action :authenticate_user!
	before_action :is_banned

	def create
		if params[:purchase][:ticket_id] == "" || params[:purchase][:quantity] == ""
			redirect_to users_tickets_path, flash: { error: "購入内容を入力してください。" }
		else
			@user = current_user
			@purchase = @user.purchases.new(purchase_params)
			@ticket = Ticket.find_by(id: params[:purchase][:ticket_id])
			@purchase.charge = @ticket.price * params[:purchase][:quantity].to_i
			@user.update(ticket: @user.ticket + @ticket.quantity * params[:purchase][:quantity].to_i)
			if @purchase.save
				redirect_to users_customer_path(current_user), flash: { notice: "チケットが#{@ticket.quantity * params[:purchase][:quantity].to_i}枚追加されました。" }
			else
				redirect_to users_tickets_path
			end
		end
	end

	private

	def purchase_params
		params.require(:purchase).permit(:ticket_id, :payment_method, :quantity)
	end

end
