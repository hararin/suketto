class Users::TicketsController < ApplicationController

	before_action :authenticate_user!

	def index
		@tickets = Ticket.all
		@purchase = Purchase.new
		@purchases = current_user.purchases.page(params[:page]).per(5)
	end

end
