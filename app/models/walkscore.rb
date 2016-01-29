class Walkscore

  attr_accessor :walkscore, :description, :updated, :logo_url, :walk_score_link

  def initialize(attrs)
    @walkscore       = attrs["walkscore"]
    @description     = attrs["description"]
    @updated         = attrs["updated"]
    @logo_url        = attrs["logo_url"]
    @walk_score_link = attrs["ws_link"]
  end

  def self.find(address, lat, lng)
    response = HTTParty.get("http://api.walkscore.com/score?format=json&address=#{address}&lat=#{lat}&lon=#{lng}&wsapikey=9a3b075dab53adcba87daee373b14efe")
    self.new response.parsed_response
  end

end
