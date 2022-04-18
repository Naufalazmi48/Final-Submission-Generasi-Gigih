class FoodsController < ApplicationController
  def index
    @foods = Food.all

    render json: response_with_data(:success, { foods: @foods}), status: :ok
  end

  def show
    @food = Food.find(params[:id])
    render json: response_with_data(:success, { food: @food }), status: :ok
    
  rescue ActiveRecord::RecordNotFound
    render json: response_with_message(:not_found, 'Id makanan tidak ditemukan'), status: :not_found
  end

  def update
    @food = Food.find(params[:id])

    if params[:name].nil? and params[:price].nil?
      render json: response_with_message(:bad_request, 'Gagal memperbarui buku, mohon isi nama atau harga buku'), status: :bad_request and return
    end

    @food.update(food_params)
    render json: response_with_message(:success, 'Data makanan berhasil diperbarui'), status: :ok
    
  rescue ActiveRecord::RecordNotFound
    render json: response_with_message(:not_found, 'Gagal memperbarui data makanan, Id makanan tidak ditemukan'), status: :not_found
  end

  def destroy
    @food = Food.find(params[:id])

    render json: response_with_message(:success, "Berhasil menghapus data makanan"), status: :ok

  rescue ActiveRecord::RecordNotFound
    render json: response_with_message(:not_found,  'Gagal menghapus data makanan, Id makanan tidak ditemukan'), status: :not_found
  end

  private 
  # Only allow a list of trusted parameters through.
    def food_params
      params.permit(:name, :price, :description)
    end

    def response_with_message(status, message) 
      response = {
        status: status,
        message: message
      }
    end

    def response_with_data(status, data) 
      response = {
        status: status,
        data: data
      }
    end
end
