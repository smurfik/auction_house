
class HousesController < ApplicationController

  def show
    @zillow = Zillow.find(params["street"], params["city"], params["state"])
    render json: @zillow.to_json
  end



  def walkscore
    @walkscore = Walkscore.find(params["address"], params["lat"], params["lng"])
    render json: @walkscore
  end
end
