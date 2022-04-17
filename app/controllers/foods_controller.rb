class FoodsController < ApplicationController
  def index
    @foods = Food.all

    response = {
      status: :success,
      data: { foods: @foods }
    }
    render json: response, status: :ok
  end

  def show
    @food = Food.find(params[:id])

    response = {
      status: :success,
      data: { food: @food }
    }
    render json: response, status: :ok
  rescue ActiveRecord::RecordNotFound
    response = {
      status: :not_found,
      message: 'Id makanan tidak ditemukan'
    }
    render json: response, status: :not_found
  end

  def update
    @food = Food.find(params[:id])

    if params[:name].nil? and params[:price].nil?
      response = {
        status: :bad_request,
        message: 'Gagal memperbarui buku, mohon isi nama atau harga buku'
      }
      render json: response, status: :bad_request and return
    end

    @food.update(food_params)

    response = {
      status: :success,
      message: 'Data makanan berhasil diperbarui'
    }
    render json: response, status: :ok
  rescue ActiveRecord::RecordNotFound
    response = {
      status: :not_found,
      message: 'Gagal memperbarui data makanan, Id makanan tidak ditemukan'
    }
    render json: response, status: :not_found
  end

  private 
  # Only allow a list of trusted parameters through.
    def food_params
      params.permit(:name, :price, :description)
    end
end
