class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:session][:email])
    if @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:notice] = "Your email or "
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
