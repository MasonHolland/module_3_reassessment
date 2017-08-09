require 'rails_helper'

# As a user
# When I visit "/"
# And I fill in a search box with “Denver” and click "search"
# Then my current path should be "/search" (ignoring params)
# And I should see the top 5 cuisines of Denver.
# And I should see the top 5 restaurants of Denver
# And I should see the name, address and locality, for each of the 5 restaurants
# *BOSS MODE* when I click page 2,
# I should see the remaining 5 restaurants.

RSpec.feature "user can search by city" do
  describe "returns top 5 cuisines and restaurants" do
    it "displays restaurants name, address, locality" do
      VCR.use_cassette("services/find_all") do
        visit '/'

        fill_in "Enter a city", with: "Denver"

        click_button "Search"

        expect(current_path).to eq('/search')

        restaurants = page.all('.restaurant')
        expect(restaurants.count).to eq(20)
        expect(restaurants.first).to have_content("Name: Park Burger")
        expect(restaurants.first).to have_content("Address: 1890 South Pearl Street 80210")
        expect(restaurants.first).to have_content("Locality: South Pearl-Platt Park")
      end
    end

    it "displays top 5 cuisines" do
      VCR.use_cassette("services/find_all") do

        visit '/'

        fill_in "Enter a city", with: "Denver"

        click_button "Search"

        expect(current_path).to eq('/search')

        cuisines = page.all('.cuisine')
        expect(cuisines.count).to eq(5)
        expect(cuisines.first).to have_content("Name: Afghani")
        expect(cuisines.last).to have_content("Name: Armenian")
      end
    end

    xit "can view next page of results" do

    end
  end
end
