class BidsController < ApplicationController

  def create
    @bid = Bid.new(params.require(:bid).permit(:price, :house_id))
    @bid.user_id = @current_user.id
    if @bid.house_id.nil?
      @house = House.create(params.require(:house).permit(:zillow_id, :address, :city, :state, :zip))
      @bid.house_id = @house.id
    end
    if @bid.save && @bid.house_id != nil
      redirect_to root_path, notice: "The bid was placed successfully!"
    else
      flash[:notice] = "The bid wasn't placed."
      render 'maps/index'
    end
  end

end
