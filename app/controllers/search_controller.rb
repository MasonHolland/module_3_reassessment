class SearchController < ApplicationController

  def show
  end

  def index
    @city_results = CityResults.new(search_params)
    binding.pry
  end

  private

    def search_params
      params.permit(:city)
    end
end
