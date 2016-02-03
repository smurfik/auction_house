class BidMailer < ApplicationMailer

  def outbid_notice(house, new_bid, old_bid)
    @previous_bidder = old_bid.user.username.titleize
    @zpid = house.zillow_id
    @street = house.address
    @last_bid = old_bid.price
    @new_bid = new_bid.price

    mail(to: "#{old_bid.user.email}" , subject: "You have been outbid!")
  end

end
