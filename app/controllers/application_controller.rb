class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

	def is_banned
		if current_user.is_banned == true
			redirect_to users_customer_path(current_user), flash: { error: "このアカウントは停止中のため一部の機能を利用できません。" }
		end
	end

	protected

	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :sex])
	end
end
