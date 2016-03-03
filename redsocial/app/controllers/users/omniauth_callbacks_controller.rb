class Users::OmniauthCallbacksController < ApplicationController

	def facebook
		@user = User.from_omniauth(request.env["omniauth.auth"])
		if @user.persisted?
			@user.remember_me = true
			sign_in_and_redirect @user, event: :authentication
			return
		end
		session["devise.auth"] = request.env["omniauth.auth"]
		render :edit
		# raise request.env["omniauth.auth"].to_yaml
	end
	def custom_sign_up
		@user = User.from_omniauth(session["devise.auth"])
		if @user.update(params_omniauth_callbacks)
			sign_in_and_redirect @user, event: :authentication
		else
			render :edit
		end
	end

	private
	def params_omniauth_callbacks
		params.require(:user).permit(:username,:name,:email)
	end

end