class ZomatoService
  def initialize(params)
    @city = params["city"]
    @city_id = nil
    @conn = Faraday.new(:url => 'https://developers.zomato.com')
  end

  def search_by_city
    parsed = parse_it(city_lookup)
    @city_id = parsed["location_suggestions"].first["id"]
  end

  def search_for_cuisines
    search_by_city
    parsed = parse_it(cuisines_search)["cuisines"][0..4]
  end

  def search_for_restaurants
    search_by_city
    parsed = parse_it(restaurants_search)["restaurants"]
  end

  private
    attr_reader :city, :conn, :city_id

    def city_lookup
      conn.get do |req|
        req.url '/api/v2.1/cities'
        req.headers["user-key"] = ENV["zomato-api-key"]
        req.params = { "q": "#{city}" }
      end
    end

    def cuisines_search
      conn.get do |req|
        req.url '/api/v2.1/cuisines'
        req.headers["user-key"] = ENV["zomato-api-key"]
        req.params = { "city_id": "#{city_id}" }
      end
    end

    def restaurants_search
      conn.get do |req|
        req.url '/api/v2.1/search'
        req.headers["user-key"] = ENV["zomato-api-key"]
        req.params = {
          "entity_id": "#{city_id}",
          "entity_type": "city",
          "sort": "rating",
          "order": "desc"
        }
      end
    end

    def parse_it(response)
      JSON.parse(response.body)
    end
end
