class MapsController < ApplicationController

  def index
    @house   = House.new
    @houses  = House.find_by(zillow_id: params[:zillow_id])
  end

end
