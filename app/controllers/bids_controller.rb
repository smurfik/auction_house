class BidsController < ApplicationController

  def create
    @bid = @current_user.bids.new(params.require(:bid).permit(:price, :house_id))
    @house = House.find_by(zillow_id: params[:house][:zillow_id])
    if @house == nil
      @house = House.create(params.require(:house).permit(:zillow_id, :address, :city, :state, :zip))
    end
    @bid.house_id = @house.id
    @old_bid =@house.bids.last
    if @bid.save
      if @house.bids.count > 1
        BidMailer.outbid_notice(@house, @bid, @old_bid).deliver_now
      end
      redirect_to root_path, notice: "The bid was placed successfully!"
    else
      flash[:notice] = "The bid wasn't placed."
      render 'maps/index'
    end

  end

  def delete
    @bid = Bid.find(params[:id])
    @bid.destroy
    redirect_to account_path
  end

end
