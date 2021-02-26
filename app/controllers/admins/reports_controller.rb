class Admins::ReportsController < ApplicationController

	def index
		@reports = Report.page(params[:page]).per(10)
	end

	def show
		@report = Report.find(params[:id])
	end

end
