class UsersController < ApplicationController
	def new
	end

	def create
		u1 = User.new(user_params)
		if u1.save
			session[:user] = User.last.user_name
			redirect_to '/messages'
		elsif u1.errors.full_messages.include? "User name has already been taken"
			session[:user] = User.where(user_name: "#{params[:user][:user_name]}")[0].user_name
			redirect_to '/messages'
		else
			flash[:errors] = u1.errors.full_messages
			redirect_to '/users/new'
		end
	end

	def logout
		session[:user] = nil
		print session[:user]
		redirect_to '/users/new' 
	end	

	def messages
		@messages = Message.all.order("id DESC")
	end

	def create_message
		@name = User.find_by(user_name: session[:user])
		@m = @name.messages.new(message_params)
		@m.save
		if @m.errors
			flash[:errors]=@m.errors.full_messages
		end			
		redirect_to '/messages'
	end

	private
		def user_params
			params.require(:user).permit(:user_name)
		end

		def message_params
			params.require(:message).permit(:message)
		end
end
