class MapsController < ApplicationController

  def index
    @house = House.find_by(params[:zillow_id])
  end

end
