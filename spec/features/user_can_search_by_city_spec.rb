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

      visit '/'

      fill_in "Enter a city to begin", with: "Denver"

      click_button "Search"

      expect(current_path).to eq('/search')

      restaurants = page.all('.restaurant')
      # expect(restaurants.count).to eq()
      expect(restaurants.first).to have_content("Name:"
      expect(restaurants.first).to have_content("Address:"
      expect(restaurants.first).to have_content("Locality:")
    end

    it "displays top 5 cuisines" do

    end

    it "can view next page of results" do

    end
  end
end