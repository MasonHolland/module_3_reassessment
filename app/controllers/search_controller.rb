class SearchController < ApplicationController

  def show
  end

  def index
    @city_results = CityResults.new(search_params)
    @city_results = @city_results.restaurants.paginate(:page => params[:page], :per_page => 5)
  end

  private

    def search_params
      params.permit(:city)
    end
end
