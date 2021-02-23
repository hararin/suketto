class Users::TicketsController < ApplicationController
	
	def index
		@tickets = Ticket.all
		@purchase = Purchase.new
		@purchases = Purchase.all
	end

end
