class HousesController < ApplicationController

  def show
  end

  def search
  end

  def walkscore
    @walkscore = Walkscore.find("10350 Mary Ave NW, Seattle, WA 98177", 47.704885, -122.375040)
    render json: @walkscore
  end

end
