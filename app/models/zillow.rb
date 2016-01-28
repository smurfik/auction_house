require 'uri'

class Zillow
  attr_accessor :address, :zpid, :city, :state, :zip, :details, :links, :images, :zestimate, :zpid, :edited_facts


  def initialize(attrs)
    @address = attrs["searchresults"]["response"]["results"]["result"]["address"]
    @zpid    = attrs["zpid"]
    @city    = attrs["city"]
    @details = attrs["searchresults"]["response"]["results"]["result"]
    @links = attrs["searchresults"]["response"]["results"]["result"]["links"]
    @zestimate  = attrs["searchresults"]["response"]["results"]["result"]["zestimate"]["amount"]["__content__"]
    @zpid = attrs["searchresults"]["response"]["results"]["result"]["zpid"].to_i
  end

  def self.search
    @address = URI.encode(params[:address])
  end


  def self.find(address)
    response = HTTParty.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz19vnw1f09vv_82rpe&address=4318-4th-Ave-NE&citystatezip=SeattleWA98105")
    z = self.new response.parsed_response
    z.images =  HTTParty.get("http://www.zillow.com/webservice/GetUpdatedPropertyDetails.htm?zws-id=X1-ZWz19vnw1f09vv_82rpe&zpid=#{z.zpid}")["updatedPropertyDetails"]["response"]["images"]["image"]["url"]
    z.edited_facts =
    HTTParty.get("http://www.zillow.com/webservice/GetUpdatedPropertyDetails.htm?zws-id=X1-ZWz19vnw1f09vv_82rpe&zpid=#{z.zpid}")["updatedPropertyDetails"]["response"]["editedFacts"]
    z
  end



end
