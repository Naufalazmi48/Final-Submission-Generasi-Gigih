class OrdersController < ApplicationController
  def index
    render json: response_with_data(:success, { orders: Order.list_order }), status: :ok
  end

  def show
    @order = Order.find(params[:id])

    render json: response_with_data(:success, { order: @order.detail }), status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: response_with_message(:not_found, 'Id order tidak ditemukan'), status: :not_found
  end

  def paid
    @order = Order.find(params[:id])

    @order.status = 'paid'
    @order.save

    render json: response_with_message(:success, 'Pesanan berhasil di bayar'), status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: response_with_message(:not_found, 'Id order tidak ditemukan'), status: :not_found
  end

  def create
    unless validate_params(%i[email orders])
      render json: response_with_message(:bad_request, 'Kolom email dan orders wajib terisi'), status: :bad_request and return
    end

    customer = Customer.new(email: params[:email])

    if customer.valid?
      customer.save
      @customer = Customer.find(customer.id)
    else
      if customer.errors[:email].first == 'is invalid'
        render json: response_with_message(:bad_request, 'Format email yang digunakan salah'), status: :bad_request and return
      end

      @customer = Customer.find_by(email: params[:email])
    end

    @foods = parse_foods(params[:orders])

    @order = Order.create(customer_id: @customer.id, date: get_current_date)

    generate_order_details(params[:orders], @foods, @order.id)

    render json: response_with_message(:success, 'Pesanan berhasil ditambahkan'), status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: response_with_message(:not_found, 'Id makanan tidak di temukan'), status: :not_found
  end

  def update
    unless validate_params(%i[orders])
      render json: response_with_message(:bad_request, 'Kolom orders wajib di isi'), status: :bad_request and return
    end

    @order = Order.find_by(id: params[:id])

    if @order.nil?
      render json: response_with_message(:not_found, 'Id pesanan tidak ditemukan'), status: :not_found and return
    end

    @foods = parse_foods(params[:orders])

    Orderdetail.delete_by(order_id: @order.id)

    generate_order_details(params[:orders], @foods, @order.id)

    customer = Customer.new(email: params[:email])

    if customer.valid?
      customer.save
      @customer = Customer.find(customer.id)
    else
      if customer.errors[:email].first == 'is invalid'
        render json: response_with_message(:bad_request, 'Format email yang digunakan salah'), status: :bad_request and return
      end

      @customer = Customer.find_by(email: params[:email])
    end

    @order.customer_id = @customer.id
    @order.save

    render json: response_with_message(:success, 'Data pesanan telah berhasil diubah'), status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: response_with_message(:not_found, 'Id makanan tidak ditemukan'), status: :not_found
  end

  def destroy
    @order = Order.find(params[:id])

    @order.destroy
    render json: response_with_message(:success, 'Pesanan berhasil dihapus'), status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: response_with_message(:not_found, 'Id pesanan tidak ditemukan'), status: :not_found
  end

  def history
    render json: response_with_data(:success, { orders: Order.list_order.select { |order| order[:date] == get_current_date } }), status: :ok
  end

  private

  def parse_foods(payload_foods)
    foods = []
    payload_foods.each do |payload_food|
      food = Food.find(payload_food[:foodId])
      foods << food unless food.nil?
    end

    foods
  end

  def generate_order_details(payload_foods, foods, order_id)
    payload_foods.each_with_index do |payload_food, index|
      Orderdetail.create(order_id: order_id, food_id: payload_food[:foodId], qty: payload_food[:qty], price: foods[index].price)
    end
  end

  def get_current_date
    DateTime.now.strftime('%d/%m/%Y')
  end
end
