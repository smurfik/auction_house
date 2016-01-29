require 'uri'

class Zillow
  attr_accessor :street, :zpid, :city, :state, :zipcode, :bedrooms, :bathrooms,
  :yearBuilt, :lotSizeSqFt, :type, :neighborhood, :images, :zestimate, :edited_facts


  def initialize(attrs)
    @street       = attrs["searchresults"]["request"]["address"]
    @zpid         = attrs["searchresults"]["response"]["results"]["result"]["zpid"]
    @city         = attrs["searchresults"]["response"]["results"]["result"]["address"]["city"]
    @state        = attrs["searchresults"]["response"]["results"]["result"]["address"]["state"]
    @zipcode      = attrs["searchresults"]["response"]["results"]["result"]["address"]["zipcode"]
    @zestimate    = attrs["searchresults"]["response"]["results"]["result"]["zestimate"]["amount"]["__content__"]
    @bedrooms     = attrs["searchresults"]["response"]["results"]["result"]["bedrooms"]
    @bathrooms    = attrs["searchresults"]["response"]["results"]["result"]["bathrooms"]
    @yearBuilt    = attrs["searchresults"]["response"]["results"]["result"]["yearBuilt"]
    @lotSizeSqFt  = attrs["searchresults"]["response"]["results"]["result"]["lotSizeSqFt"]
    @type         = attrs["searchresults"]["response"]["results"]["result"]["useCode"]
    @neighborhood = attrs["searchresults"]["response"]["results"]["result"]["localRealEstate"]["region"]["name"]
    @sqft         = attrs["searchresults"]["response"]["results"]["result"]["finishedSqFt"]
  end

  def self.search
    @address = URI.encode(params[:address])
  end


  def self.find(address, city, state, zipcode)
    response = HTTParty.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz19vnw1f09vv_82rpe&address=#{address}&citystatezip=#{city}#{state}#{zipcode}")
    zillow = self.new response.parsed_response
    zillow_api = HTTParty.get("http://www.zillow.com/webservice/GetUpdatedPropertyDetails.htm?zws-id=X1-ZWz19vnw1f09vv_82rpe&zpid=#{zipcode}")
    zillow.images = zillow_api
    zillow.edited_facts = zillow_api
    zillow
  end



end
