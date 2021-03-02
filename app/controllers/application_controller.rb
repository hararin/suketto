class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

	def is_banned
		if current_user.is_banned == true
			redirect_to users_customer_path(current_user), flash: { error: "このアカウントは停止中のため一部の機能を利用できません。" }
		end
	end

	def any_requests_or_participants?(user)
	    @requests = user.requests.all
	    @req_in_progress = []
	    @participants = user.participants.all
	    @par_in_progress = []
	    @requests.each do |request|
	    	if request.datetime >= DateTime.now
	        @req_in_progress.push(request)
	    	end
	    end
	    @participants.each do |participant|
	    	if participant.request.datetime >= DateTime.now
	        @par_in_progress.push(participant)
	    	end
	    end
	    if @req_in_progress.blank? == false
	    	redirect_to users_customer_path(user), flash: { error: "進行中の依頼があるため退会できません。" }
	    	return
	    elsif @par_in_progress.blank? == false
	    	redirect_to users_customer_path(user), flash: { error: "進行中の助っ人があるため退会できません。" }
	    	return
	    else
		    @user.update(is_deleted: true)
			reset_session
			redirect_to '/'
	    end
	end

	protected

	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :sex])
	end
end
