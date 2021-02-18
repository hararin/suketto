class Admins::TicketsController < ApplicationController

	def index
		@tickets = Ticket.all
		@ticket = Ticket.new
	end

	def create
		@ticket = Ticket.new(ticket_params)
		if @ticket.save
			redirect_to admins_tickets_path
		else
			render :index
		end
	end

	def edit
		@ticket = Ticket.find(params[:id])
	end

	def update
		@ticket = Ticket.find(params[:id])
		if @ticket.update(ticket_params)
			redirect_to admins_tickets_path
		else
			render :index
		end
	end

	def destroy
		@ticket = Ticket.find(params[:id])
		@ticket.destroy
		redirect_to admins_tickets_path
	end

	private
	def ticket_params
		params.require(:ticket).permit(:name, :price)
	end

end
