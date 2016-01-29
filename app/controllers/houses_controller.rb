class HousesController < ApplicationController

  def show
    @zillow = Zillow.find(params[:street], params[:city], params[:state], params[:zipcode])
    render json: @zillow.to_json
  end

  def search
  end

  def walkscore
    @walkscore = Walkscore.find(params["address"], params["lat"], params["lng"])
    render json: @walkscore
  end
end
