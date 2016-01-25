class UsersController < ApplicationController


  def create
    @user = User.new(user_params)
    @user.save
    session[:user_id] = @user.id
    redirect_to "/"
  end


  def show
    @current_user = User.find(session[:user_id])
  end



  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :current_city, :bids_count)
  end

end