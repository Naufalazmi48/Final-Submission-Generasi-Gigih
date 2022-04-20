class CategoriesController < ApplicationController
  def index
    @categories = Category.all

    render json: response_with_data(:success, { categories: @categories.map { |category| category.as_response}}), status: :ok
  end

  def show
    @category = Category.find(params[:id])
    render json: response_with_data(:success, { category: @category.as_response }), status: :ok
    
  rescue ActiveRecord::RecordNotFound
    render json: response_with_message(:not_found, 'Kategori tidak ditemukan'), status: :not_found
  end
end
