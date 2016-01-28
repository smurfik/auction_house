class HousesController < ApplicationController

  def show
  end

  def search
  end

  def walkscore
    @walkscore = Walkscore.find(params["address"], params["lat"], params["lng"])
    render json: @walkscore
  end

end
