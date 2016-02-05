class HousesController < ApplicationController

  def show
    @zillow = Zillow.find(params["street"], params["city"], params["state"])
    render :json=> @zillow
  end

  def walkscore
    @walkscore = Walkscore.find(params["address"], params["lat"], params["lng"])
    render json: @walkscore
  end

  def shut_up_seattle
    @shutupseattle = ShutUpSeattle.find(params["lat"], params["lng"])
    render json: @shutupseattle.to_json
  end

  def place_pins
    @houses = House.where.not(bids_count: 0)
    render json: @houses
  end

  def bid_data
    house = House.find_by(zillow_id: params[:zpid])
    @bid_data = if house.nil?
      []
    else
      house.bids
    end
    render json: @bid_data
  end

end
