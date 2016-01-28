class HousesController < ApplicationController

  def show
    address = "http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz19vnw1f09vv_82rpe&address=#{@street}&citystatezip=#{@city}#{@state}#{@zipcode}"
    @zillow = Zillow.find(address)
    render json: @zillow

    @street         = params[:street]
    @city           = params[:city]
    @state          = params[:state]
    @zipcode        = params[:zipcode]
    @zestimate      = params[:zestimate]
    @latitude       = params[:latitude]
    @longitude      = params[:longitude]
    @bedrooms       = params[:bedrooms]
    @bathrooms      = params[:bathrooms]
    @year_built     = params[:yearBuilt]
    @year_updated   = params[:yearUpdated]
    @lot_size       = params[:lotSizeSqFt]
    @finishedsqft   = params[:finishedSqFt]
    @floors         = params[:numFloors]
    @heating_system = params[:heatingSystem]
    @heating_source = params[:heatingSources]
    @parking        = params[:parkingType]

    @json           = response.to_json
    # take params and enter address data into url
    # show Json (render jason) -- make hash
  end

  def search
  end

end
