class ZomatoService
  def initialize(params)
    @city = params[:city]
    @conn = Faraday.new(:url => 'https://developers.zomato.com/api/v2.1')
  end

  def search_by_city
    city_id = city_lookup
  end

  private
    attr_reader :city, :conn

    def city_lookup
      response = conn.get do |req|
        req.url '/cities'
        req.headers['user-key'] = ENV['zomato-api-key']
        req.body = "{ 'q': #{city} }"
      end
      parsed = parse_it(response)
      parsed.first["id"]
    end

    def cuisines_search(city_id)
    end

    def restaurants_search(city_id)
    end

    def parse_it(response)
      JSON.parse(response.body)
    end
end
