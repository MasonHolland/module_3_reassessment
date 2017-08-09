class ZomatoService
  def initialize(params)
    @city = params["city"]
    @conn = Faraday.new(:url => 'https://developers.zomato.com')
  end

  def search_by_city
    city_id = city_lookup
  end

  def search_for_cuisines
  end

  def search_for_restaurants
  end

  private
    attr_reader :city, :conn

    def city_lookup
      response = conn.get do |req|
        req.url '/api/v2.1/cities'
        req.headers["user-key"] = ENV["zomato-api-key"]
        req.params = { "q": "#{city}" }
      end
      parsed = parse_it(response)
      parsed["location_suggestions"].first["id"]
    end

    def cuisines_search(city_id)
    end

    def restaurants_search(city_id)
    end

    def parse_it(response)
      JSON.parse(response.body)
    end
end
