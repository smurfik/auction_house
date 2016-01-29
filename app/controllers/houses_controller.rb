class HousesController < ApplicationController

  def show
    @zillow = Zillow.find(params[:street], params[:city], params[:state], params[:zipcode])
    render json: @zillow.to_json
  end

  def search
  end

end
