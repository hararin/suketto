class Users::ReportsController < ApplicationController

	before_action :authenticate_user!
	before_action :is_banned

	def new
		@report = Report.new
		@respondent = User.find(params[:customer_id])
	end

	def create
		@respondent = User.find(params[:customer_id])
		@report = Report.new(report_params)
		@report.user_id = current_user.id
		@report.respondent_id = @respondent.id
		if @report.save
			redirect_to users_customer_path(@respondent), flash: { notice: "#{@respondent.name}さんを通報しました。" }
		else
			render :new
		end
	end

	private

	def report_params
		params.require(:report).permit(:respondent_id, :content)
	end

end
