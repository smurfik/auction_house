class BidMailer < ApplicationMailer

  def outbid_notice
    # @outbid = Bid.find(bid_id)
    mail(to: "khambro@yahoo.com", subject: "You have been outbid!")
  end

end
