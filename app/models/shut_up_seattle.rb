class ShutUpSeattle

  attr_accessor :score, :noises

  def initialize(attrs)
    @score  = attrs["score"]
  end

  def self.find(lat, lng)
    response = HTTParty.get("http://api.shutupseattle.com/score?latitude=#{lat}&longitude=#{lng}")
    self.new response.parsed_response
  end
end
