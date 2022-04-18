require 'rails_helper'

RSpec.describe "Foods", type: :request do

  before(:each) do
    Food.delete_all
    Category.delete_all
  end
  
  describe "GET /index" do
    it 'get foods correctly' do
      # Given
      food = FactoryBot.create(:food, name: "Makanan 1")
      expected = {
        status: :success,
        data: { foods: [food]}
      }.to_json
      # When
      get '/foods'
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    it 'get food by id correctly' do
      # Given
      food = FactoryBot.create(:food, name: "Makanan 1")
      expected = {
        status: :success,
        data: { food: food}
      }.to_json
      # When
      get "/foods/#{food.id}"
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(200)
    end

    it 'should return 404 when id not found' do
      # Given
      expected = {
        status: :not_found,
        message: 'Id makanan tidak ditemukan'
      }.to_json
      # When
      get "/foods/x"
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(404)
    end
  end

  describe "put /update" do
    it 'update food by id correctly' do
      # Given
      food = FactoryBot.create(:food)
      expected = {
        status: :success,
        message: 'Data makanan berhasil diperbarui'
      }.to_json
      # When
      put "/foods/#{food.id}", params: { name: "Makanan1", price: 20000}
      # then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(200)
      expect(Food.first.price).to eq(20000)
      expect(Food.first.name).to eq('Makanan1')
    end

    it 'update food by invalid id' do
      # Given
      expected = {
        status: :not_found,
        message: 'Gagal memperbarui data makanan, Id makanan tidak ditemukan'
      }.to_json
      # When
      put "/foods/x", params: {name: 'Makanan1'}
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(404)
    end

    it 'update food without payload name and price' do 
      # Given
      food = FactoryBot.create(:food)
      expected = {
        status: :bad_request,
        message: 'Gagal memperbarui buku, mohon isi nama atau harga buku'
      }.to_json
      # When
      put "/foods/#{food.id}"
      # then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(400)
    end
  end

  describe 'delete /destroy' do
    it 'should return 404 when food id not found' do
       # Given
      expected = {
        status: :not_found,
        message: 'Gagal menghapus data makanan, Id makanan tidak ditemukan'
      }.to_json
      # When
      delete "/foods/x"
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(404)
    end

    it 'should return success message when delete using valid id' do
      # Given
      food = FactoryBot.create(:food)
      expected = {
        status: :success,
        message: 'Berhasil menghapus data makanan'
      }.to_json
      # When
      delete "/foods/#{food.id}"
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(200)
    end
  end

  describe 'post /create' do
    it 'should return bad request exception when create makanan without name, price, description, and categories' do
      # Given
      expected = {
        status: :bad_request,
        message: 'Gagal menambahkan buku, mohon isi nama, harga, deskripsi, dan kategori'
      }.to_json
      # When
      post "/foods"
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(400)
    end

    it 'should return exception when create makanan with duplicate name' do
      # Given
      food = FactoryBot.create(:food, name: "Nasi Goreng")
      expected = {
        status: :bad_request,
        message: "Gagal menambahkan data makanan, makanan tersebut sudah terdaftar"
      }
      # When
      post "/foods", params: { name: food.name, price: 0, description: food.description, categories: food.categories}.to_json
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(400)
      
    end
  end
  
end
