require 'rails_helper'

RSpec.service "zomato service can make api calls" do
  context "it returns desired products" do
    it "returns city id when provided with city" do
      params = { "city" => "Denver"}
      zomser = ZomatoService.new(params).search_by_city

      expect(zomser).to eq(305)
    end

    xit "returns top 5 cuisines when provided with city_id" do

    end

    xit "returns top 5 restaurants when provided with city_id" do

    end
  end
end
