class CategoriesController < ApplicationController
  def index
    @categories = Category.all

    render json: response_with_data(:success, { categories: @categories.map { |category| category.as_response}}), status: :ok
  end
end
