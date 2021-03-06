class UsersController < ApplicationController


  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/"
    else
      redirect_to "/new-user", notice: "Username or email not complete, or passwords do not match. You tell me!"
    end
  end


  def show
    @current_user = User.find(session[:user_id])
  end

  def sign_in
  end

  def account
    @user   = User.find(session[:user_id])
    @bids   = Bid.all
  end



  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :current_city, :bids_count, :password_confirmation)
  end

end
