class CityResults

  def initialize(param)
    @city = param["city"].downcase
    @zomser = ZomatoService.new(city)
  end

  def make_calls
    @zomser.search_for_city
    @restaurants = zomser.search_for_restaurants
    @cuisines = zomser.search_for_cuisines
  end

  private
    attr_reader :city, :zomser
end
