require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  after(:all) do
    Food.delete_all
    Category.delete_all
    Order.delete_all
    Customer.delete_all
    Orderdetail.delete_all
  end

  before(:all) do
    @food1 = FactoryBot.create(:food)
    @food2 = FactoryBot.create(:food)
    @customer = Customer.create(email: 'naufalazmi@gmail.com')
    @order = Order.create(customer_id: @customer.id, date: '21/04/2022')
    @order_detail1 = Orderdetail.create(order_id: @order.id, food_id: @food1.id, qty: 2, price: @food1.price)
    @order_detail2 = Orderdetail.create(order_id: @order.id, food_id: @food2.id, qty: 5, price: @food2.price)
  end

  describe 'GET /index' do
    it 'returns all orders' do
      # Given
      expected = {
        status: :success,
        data: { orders: Order.list_order }
      }.to_json

      # when
      get '/orders'
      # then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /show' do
    it 'Should return exception when search order with invalid id' do
      # Given
      expected = {
        status: :not_found,
        message: 'Id order tidak ditemukan'
      }.to_json
      # When
      get '/orders/x'
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(404)
    end

    it 'should success when search order by valid id' do
      # Given
      expected = {
        status: :success,
        data: { order: @order.detail }
      }.to_json
      # When
      get "/orders/#{@order.id}"
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /paid' do
    it 'Should return exception when paid with invalid id' do
      # Given
      expected = {
        status: :not_found,
        message: 'Id order tidak ditemukan'
      }.to_json
      # When
      get '/orders/x'
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(404)
    end

    it 'Should changed status from new to paid' do
      expected = {
        status: :success,
        message: 'Pesanan berhasil di bayar'
      }.to_json
      # When
      post "/orders/#{@order.id}/paid"
      # Then
      expect(Order.find(@order.id).status).to eq('paid')
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /create' do
    it 'Should return exception when nothing input data email and orders' do
      # Given
      expected = {
        status: :bad_request,
        message: 'Kolom email dan orders wajib terisi'
      }.to_json
      # When
      post '/orders'
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(:bad_request)
    end

    it 'Should return exception when input invalid email' do
      # Given
      expected = {
        status: :bad_request,
        message: 'Format email yang digunakan salah'
      }.to_json
      # When
      post '/orders', params: { email: 'abc', orders: [{ foodId: @food1.id, qty: 2 }] }
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(:bad_request)
    end

    it 'Should create new Customer when email not registered' do
      # When
      post '/orders', params: { email: 'naufal@gmail.com', orders: [{ foodId: @food1.id, qty: 2 }] }
      # Then
      expect(Customer.find_by(email: 'naufal@gmail.com').nil?).to be false
    end

    it 'should return exception when input invalid food id' do
      # Given
      expected = {
        status: :not_found,
        message: 'Id makanan tidak di temukan'
      }.to_json
      # When
      post '/orders', params: { email: 'naufal@gmail.com', orders: [{ foodId: '100', qty: 2 }] }
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(:not_found)
    end

    it 'should success when input valid email and orders' do
      # Given
      food = FactoryBot.create(:food)
      expected = {
        status: :success,
        message: 'Pesanan berhasil ditambahkan'
      }.to_json
      # When
      post '/orders', params: { email: 'naufal@gmail.com', orders: [{ foodId: food.id, qty: 2 }] }
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(Order.all.size).to eq(2)
      expect(Orderdetail.all.size).to eq(3)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /update' do
    it 'Should return exception when nothing input new orders' do
      # Given
      expected = {
        status: :bad_request,
        message: 'Kolom orders wajib di isi'
      }.to_json
      # When
      put "/orders/#{@order.id}"
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(400)
    end

    it 'Should return exception when input invalid id' do
        # Given
        expected = {
          status: :not_found,
          message: 'Id pesanan tidak ditemukan'
        }.to_json
        # When
        put '/orders/x', params: {orders: [foodId: @food1.id, qty: 2]}
        # Then
        expect(response.body).to eq(expected.to_s)
        expect(response).to have_http_status(404)
    end

    it 'should delete all order detail and changed to new orders' do
      # Given
      food = FactoryBot.create(:food)
      # When
      put "/orders/#{@order.id}", params: {orders: [foodId: food.id, qty: 2]}
      # Then
      expect(Orderdetail.find_by(id: @order_detail1.id).nil?).to eq(true)
      expect(Orderdetail.find_by(id: @order_detail2.id).nil?).to eq(true)
      expect(Orderdetail.find_by(food_id: food.id).nil?).to eq(false)
      expect(Orderdetail.all.size).to eq(1)
    end

    it 'should updated customer id in order when update email' do
       # When
      put "/orders/#{@order.id}", params: {email: "naufalazmi@gmail.com", orders: [foodId: @food1.id, qty: 2]}
      # Then
      expect(@order.customer_id).not_to eq(@customer.id)
    end

    it 'should return success message when using valid email and orders' do
      # Given
      food = FactoryBot.create(:food)
      expected = {
        status: :success,
        message: "Data pesanan telah berhasil diubah"
      }.to_json
      # When
      put "/orders/#{@order.id}", params: {email: "naufalazmi@gmail.com", orders: [foodId: food.id, qty: 2]}
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(200)
    end
  end
end
