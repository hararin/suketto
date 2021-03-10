class Admins::ReportsController < ApplicationController

	before_action :authenticate_admin!

	def index
		@reports = Report.page(params[:page]).per(10)
	end

	def show
		@report = Report.find(params[:id])
		@respondent = User.find(@report.respondent_id)
		@reports = Report.where(respondent_id: @report.respondent_id)
	end

end
