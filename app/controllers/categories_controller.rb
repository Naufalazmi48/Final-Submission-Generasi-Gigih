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

  def create

    unless validate_params([:name])
      render json: response_with_message(:bad_request, "Kolom nama kategori wajib di isi"), status: :bad_request and return
    end
    
    @category = Category.new
    @category.name = params[:name]

    if @category.valid?
      @category.save
    else
      unless @category.errors[:name].empty?
        render json: response_with_message(:bad_request, "Kategori ini sudah ada"), status: :bad_request and return
      end
    end

    render json: response_with_message(:created, "Berhasil menambahkan kategori").merge(data: { categoryId: @category.id }), status: :created
  end

  def update
    unless validate_params([:name])
      render json: response_with_message(:bad_request, "Kolom nama kategori wajib di isi"), status: :bad_request and return
    end
    
     @category = Category.find(params[:id])
     @category.name = params[:name]

    if @category.valid?
       @category.save
    else
      unless @category.errors[:name].empty?
        render json: response_with_message(:bad_request, "Kategori ini sudah ada"), status: :bad_request and return
      end
    end
    
    render json: response_with_message(:success, "Berhasil memperbarui kategori").merge(data: { categoryId: @category.id }), status: :ok

    rescue ActiveRecord::RecordNotFound
    render json: response_with_message(:not_found, 'Kategori tidak ditemukan'), status: :not_found
  end
  
end
