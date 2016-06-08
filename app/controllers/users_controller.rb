class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.update(api_key: SecureRandom.hex)
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:danger] = "There was a problem with your request. Please make sure you entered a valid email that has not been used to generate an api key before, and that your passwords match"
      render :new
    end
  end

  def update
    if current_user
      current_user.update(api_key: SecureRandom.hex)
    end
    redirect_to current_user
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
