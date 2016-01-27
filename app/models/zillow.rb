class Zillow
  attr_accessor :address, :zpid, :city, :state, :zip, :edited_facts, :links, :images, :zestimate


  def initialize(attrs)
    @address = attrs["updatedPropertyDetails"]["response"]["address"]
    @zpid    = attrs["zpid"]
    @city    = attrs["city"]
    @edited_facts = attrs["updatedPropertyDetails"]["response"]["editedFacts"]
    @links = attrs["updatedPropertyDetails"]["response"]["links"]
    @images = attrs["updatedPropertyDetails"]["response"]["images"]
  end



  def self.find
    response = HTTParty.get("http://www.zillow.com/webservice/GetUpdatedPropertyDetails.htm?zws-id=X1-ZWz19vnw1f09vv_82rpe&zpid=48749425")
    z = self.new response.parsed_response
    z.zestimate = HTTParty.get("http://www.zillow.com/webservice/GetZestimate.htm?zws-id=X1-ZWz19vnw1f09vv_82rpe&zpid=48749425")["zestimate"]["response"]["zestimate"]["amount"]["__content__"]
    z
  end

  def self.all
    response = HTTParty.get("http://www.zillow.com/webservice/GetUpdatedPropertyDetails.htm?zws-id=X1-ZWz19vnw1f09vv_82rpe&zpid=48749425")
    response.parsed_response.collect do |house_hash|
      self.new house_hash
    end

  end


end



 # #<HTTParty::Response:0x7faeb28a8d70 parsed_response={"updatedPropertyDetails"=>
 # {"request"=>{"zpid"=>"48749425"},
 # "message"=>{"text"=>"Request successfully processed", "code"=>"0"},
 # "response"=>{"zpid"=>"48749425", "pageViewCount"=>{"currentMonth"=>"18810", "total"=>"18810"}, "address"=>{"street"=>"2114 Bigelow Ave N", "zipcode"=>"98109", "city"=>"Seattle", "state"=>"WA", "latitude"=>"47.637933", "longitude"=>"-122.347938"}, "links"=>{"homeDetails"=>"http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/", "photoGallery"=>"http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/#image=lightbox%3Dtrue", "homeInfo"=>"http://www.zillow.com/homedetails/2114-Bigelow-Ave-N-Seattle-WA-98109/48749425_zpid/"}, "images"=>{"count"=>"1", "image"=>{"url"=>"http://photos3.zillowstatic.com/p_d/ISxb3qa8s1cwx01000000000.jpg"}},
 #
 # "editedFacts"=>{"useCode"=>"SingleFamily", "bedrooms"=>"4", "bathrooms"=>"3.0", "finishedSqFt"=>"3470", "lotSizeSqFt"=>"4680", "yearBuilt"=>"1924", "yearUpdated"=>"2003", "numFloors"=>"2", "basement"=>"Finished", "roof"=>"Composition", "view"=>"Water, City, Mountain", "parkingType"=>"Off-street", "heatingSources"=>"Gas", "heatingSystem"=>"Forced air", "rooms"=>"Laundry room, Walk-in closet, Master bath, Office, Dining room, Family room, Breakfast nook"}, "neighborhood"=>"Queen Anne", "schoolDistrict"=>"Seattle", "elementarySchool"=>"John Hay", "middleSchool"=>"McClure"}, "schemaLocation"=>"http://www.zillow.com/static/xsd/UpdatedPropertyDetails.xsd http://www.zillowstatic.com/vstatic/272e7d3/static/xsd/UpdatedPropertyDetails.xsd"}}
