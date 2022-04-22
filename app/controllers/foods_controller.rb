class FoodsController < ApplicationController
  def index
    @foods = Food.all

    render json: response_with_data(:success, { foods: @foods.map { |food| food.as_response } }), status: :ok
  end

  def show
    @food = Food.find(params[:id])
    render json: response_with_data(:success, { food: @food.as_response }), status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: response_with_message(:not_found, 'Id makanan tidak ditemukan'), status: :not_found
  end

  def update
    @food = Food.find(params[:id])

    unless validate_params(%i[name price])
      render json: response_with_message(:bad_request, 'Gagal memperbarui data makanan, mohon isi nama atau harga makanan'), status: :bad_request and return
    end

    @food.name = params[:name]
    @food.price = params[:price]
    @food.description = params[:description]

    @food.categories = parse_categories(params[:categories]) unless params[:categories].nil?

    @food.save

    render json: response_with_message(:success, 'Data makanan berhasil diperbarui'), status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: response_with_message(:not_found, 'Gagal memperbarui data makanan, Id makanan tidak ditemukan'), status: :not_found
  end

  def destroy
    @food = Food.find(params[:id])

    @food.destroy
    render json: response_with_message(:success, 'Berhasil menghapus data makanan'), status: :ok
    
  rescue ActiveRecord::RecordNotFound
    render json: response_with_message(:not_found, 'Gagal menghapus data makanan, Id makanan tidak ditemukan'), status: :not_found
  end

  def create
    unless validate_params(%i[name price description categories])
      render json: response_with_message(:bad_request, 'Gagal menambahkan data makanan, mohon isi nama, harga, deskripsi, dan kategori'), status: :bad_request and return
    end

    categories = parse_categories(params[:categories])

    if categories.empty?
      render json: response_with_message(:bad_request, 'Gagal menambahkan data makanan, kategori tidak ditemukan'), status: :bad_request and return
    end

    @food = Food.new do |food|
      food.name = params[:name]
      food.price = params[:price]
      food.description = params[:description]
      food.categories = categories
    end

    if @food.valid?
      @food.save
    else
      unless @food.errors[:name].empty?
        render json: response_with_message(:bad_request, 'Data makanan ini sudah tersedia sebelumnya'), status: :bad_request and return
      end
    end

    render json: response_with_message(:success, 'Makanan telah berhasil ditambahkan').merge(data: { foodId: @food.id }), status: :created
  end

  private


  def parse_categories(payload_categories)
    categories = []
    payload_categories.each do |payload_category|
      category = Category.find_by(id: payload_category[:id])
      categories << category unless category.nil?
    end

    categories
  end
end
