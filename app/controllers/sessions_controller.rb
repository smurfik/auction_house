class SessionsController < ApplicationController

  def sign_out
    session.delete(:user_id)
    redirect_to "/", notice: "You have been signed out"
  end

  def sign_in
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to "/", notice: "You have been signed in"
    else
      redirect_to "/", notice: "Wrong username/password. Try again."
    end
  end

end
