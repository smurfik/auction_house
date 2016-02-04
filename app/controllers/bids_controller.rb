class BidsController < ApplicationController

  def create
    @bid = @current_user.bids.new(params.require(:bid).permit(:price, :house_id))
    @house = House.find_by(zillow_id: params[:house][:zillow_id])
    if @house != nil
      @old_bid = @house.bids.last
    else
      @house = House.create(params.require(:house).permit(:zillow_id, :address, :city, :state, :zip))
    end
    @bid.house_id = @house.id
    if @old_bid && @old_bid.user.id == @current_user.id
      render json: {notice: "You are currently the higest bidder on this house and can not place another bid."}
    else
        if @bid.price < (@house.bids.maximum(:price) || 0)
          render json: {notice: "Bid placed must be higher than highest bid of #{@house.bids.maximum(:price)}"}
       else
          if @bid.save
            if @house.bids.count > 1
              BidMailer.outbid_notice(@house, @bid, @old_bid).deliver_now
            end
            render json: {notice: "Your bid was placed successfully!"}
          else
            render json: {notice: "An error occurred and your bid wasn't placed."}
         end
      end
    end
  end

  def delete
    @bid = Bid.find(params[:id])
    @bid.destroy
    redirect_to account_path
  end

end

# TO DO!
# - make controller work with index to show current highest bid
# - if current user has bid on house don't show bid button
