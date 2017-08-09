class ZomatoService
  attr_reader :city

  def initialize(params)
    @city = params[:city]
  end

  def search_by_city
    city_id = city_lookup

  end

  private

  def city_lookup
  end

  def cuisines_search(city_id)
  end

  def restaurants_search(city_id)
  end
end
