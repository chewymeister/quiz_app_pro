class SessionsController < ApplicationController
	def new

	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			redirect_to root_path, :notice => "Welcome back #{user.first_name}!"
		else
			flash.now[:errors] = ["The email or password you typed did not work"]
			render 'new'
		end
	end

	def destroy
		flash[:notice] = "Goodbye!"
		session[:user_id] = nil
		redirect_to root_path
	end
end
