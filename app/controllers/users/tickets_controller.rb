class Users::TicketsController < ApplicationController

	before_action :authenticate_user!
	before_action :is_banned

	def index
		@tickets = Ticket.all
		@purchase = Purchase.new
		@purchases = current_user.purchases.page(params[:page]).per(5)
	end

end
