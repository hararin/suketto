class Users::ReportsController < ApplicationController

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
			redirect_to new_users_customer_report_path(@respondent), flash: { error: "通報内容を入力してください。" }
		end
	end

	private

	def report_params
		params.require(:report).permit(:respondent_id, :content)
	end

end