class CityResults
  attr_reader :city, :restaurants, :cuisines

  def initialize(param)
    @city = param["city"].capitalize
    @zomser = ZomatoService.new(city.downcase)
    @restaurants = restaurants
    @cuisines = cuisines
  end

  def restaurants
    zomser.search_for_city
    zomser.search_for_restaurants.map do |restaurant|
      { "name" => restaurant["restaurant"]["name"],
        "address" => restaurant["restaurant"]["location"]["address"],
        "locality" => restaurant["restaurant"]["location"]["locality"]
      }
    end
  end

  def cuisines
    zomser.search_for_cuisines.map do |cuisine|
      cuisine["cuisine"]["cuisine_name"]
    end
  end

  private
    attr_reader :zomser
end
