require 'open-uri'

class Zillow
  attr_accessor :street, :zpid, :city, :state, :zipcode, :bedrooms, :bathrooms,
  :yearBuilt, :lotSizeSqFt, :type, :neighborhood, :images, :zestimate, :edited_facts, :last_sold, :description, :rent, :sold_price, :sold_date


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
    @rent         = attrs["searchresults"]["response"]["results"]["result"]["rentZestimate"]
    if attrs["searchresults"]["response"]["results"]["result"]["lastSoldPrice"]
      @sold_price   = attrs["searchresults"]["response"]["results"]["result"]["lastSoldPrice"]["__content__"]
    end
    if attrs["searchresults"]["response"]["results"]["result"]["lastSoldDate"]
      @sold_date    = attrs["searchresults"]["response"]["results"]["result"]["lastSoldDate"]
    end
  end

  # def self.search
  #   @address = URI.encode(params[:address])
  # end


  def self.find(address, city, state)

    response = HTTParty.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz19vnw1f09vv_82rpe&address=#{address}&citystatezip=#{city},#{state}")
    puts response.inspect
    zillow = self.new response.parsed_response
    zillow_api = HTTParty.get("http://www.zillow.com/webservice/GetUpdatedPropertyDetails.htm?zws-id=X1-ZWz19vnw1f09vv_82rpe&zpid=#{zillow.zpid}")
    zillow.images       = zillow_api["updatedPropertyDetails"]["response"]
    zillow.edited_facts = zillow_api["updatedPropertyDetails"]["response"]
    zillow.description  = zillow_api["updatedPropertyDetails"]["response"]["homeDescription"]
    zillow
  end

url = "http://www.zillow.com/webservice/GetDeepComps.htm?zws-id=X1-ZWz19vnw1f09vv_82rpe&zpid=48749425&count=5"

end
