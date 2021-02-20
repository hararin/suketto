class Users::PurchasesController < ApplicationController

	def create
		@user = current_user
		@purchase = @user.purchases.new(purchase_params)
		@ticket = Ticket.find_by(id: params[:purchase][:ticket_id])
		@purchase.charge = @ticket.price * params[:purchase][:quantity].to_i
		@user.update(ticket: @user.ticket + @ticket.quantity * params[:purchase][:quantity].to_i)
		if @purchase.save
			redirect_to users_customer_path(current_user)
		end
	end

	private

	def purchase_params
		params.require(:purchase).permit(:ticket_id, :payment_method, :quantity)
	end

end
