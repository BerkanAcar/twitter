class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update]
  before_action :set_user, only:[:show, :edit, :update, :destroy]
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.tweets.create
		if @user.save
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		
	end

	def update
		if @user.update(user_params)
			redirect_to @current_user
		else
			render 'edit'
		end
	end

	def profile
		@user_tweets = @user.tweets
	end
	private
		def set_user
	  	@user = User.find(params[:id])
	  end

	  def logged_in_user
		  unless user_signed_in?
		    flash[:message] = "Please log in."
		    redirect_to new_user_session_path
		  end
	  end
		def user_params
			params.require(:user).permit(:email, :password, :name, :surname, :gender, :birth_day, :city, :phone_no, :info, :about, :avatar)
		end
end
