require 'rails_helper'

describe ZomatoService do
  attr_reader :service

  before(:each) do
    params = "denver"
    @service = ZomatoService.new(params)
  end

  describe "#cities" do
    it "returns city id when provided with city" do
      VCR.use_cassette("services/find_city_id") do
        city_id = service.search_for_city

        expect(city_id).to eq(305)
      end
    end
  end

  describe "#cuisines" do
    it "returns top 5 cuisines when provided with city_id" do
      VCR.use_cassette("services/cuisines_search") do
        service.search_for_city

        cuisines = service.search_for_cuisines
        cuisine = cuisines.first["cuisine"]

        expect(cuisines.count).to eq(5)
        expect(cuisine["cuisine_name"]).to eq("Afghani")
        expect(cuisine["cuisine_id"]).to eq(6)
        expect(cuisines.last["cuisine"]["cuisine_name"]).to eq("Armenian")
        expect(cuisines.last["cuisine"]["cuisine_id"]).to eq(175)
      end
    end
  end

  describe "#restaurants" do
    it "returns top 5 restaurants when provided with city_id" do
      VCR.use_cassette("services/restaurants_search") do
        service.search_for_city

        restaurants = service.search_for_restaurants
        restaurant = restaurants.first["restaurant"]

        expect(restaurants.count).to eq(20)
        expect(restaurant["id"]).to eq("16973776")
        expect(restaurant["name"]).to eq("Park Burger")
        expect(restaurant["location"]["address"]).to eq("1890 South Pearl Street 80210")
        expect(restaurant["location"]["locality"]).to eq("South Pearl-Platt Park")
      end
    end
  end
end
