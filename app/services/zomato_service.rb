class ZomatoService
  def initialize(param)
    @city = param
    @conn = Faraday.new(:url => 'https://developers.zomato.com')
    @city_id = search_for_city
  end

  def search_for_city
    parsed = parse_it(city_lookup)
    parsed["location_suggestions"].first["id"]
  end

  def search_for_cuisines
    parse_it(cuisines_search)["cuisines"][0..4]
  end

  def search_for_restaurants
    parse_it(restaurants_search)["restaurants"]
  end

  private
    attr_reader :city, :conn, :city_id

    def dynamic_call(args)
      conn.get do |req|
        req.url "#{args["url"]}"
        req.headers["user-key"] = ENV["zomato-api-key"]
        req.params = args["params"]
      end
    end

    def city_lookup
      dynamic_call({
        "url" => '/api/v2.1/cities',
        "params" => { "q": "#{city}"}
        })
    end

    def cuisines_search
      dynamic_call({
        "url" => '/api/v2.1/cuisines',
        "params" => { "city_id": "#{city_id}"}
        })
    end

    def restaurants_search
      dynamic_call({
        "url" => '/api/v2.1/search',
        "params" => {
          "entity_id": "#{city_id}",
          "entity_type": "city",
          "sort": "rating",
          "order": "desc"}
        })
    end

    def parse_it(response)
      JSON.parse(response.body)
    end
end
