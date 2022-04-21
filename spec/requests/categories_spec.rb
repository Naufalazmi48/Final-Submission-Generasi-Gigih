require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  before(:each) do
    Category.delete_all
  end

  describe 'GET /index' do
    it 'should return all category' do
      # Given
      category = FactoryBot.create(:category)
      expected = {
        status: :success,
        data: { categories: [category.slice(:id, :name)]}
      }.to_json
      # When
      get '/categories'
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /show' do
    it 'Should return exception when invalid category id' do
      # Given
      category = FactoryBot.create(:category)
      expected = {
        status: :not_found,
        message: "Kategori tidak ditemukan"
      }.to_json
      # When
      get '/categories/xyz'
      # then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(404)
    end

    it 'should return correct category when using valid id' do
       # Given
      category = FactoryBot.create(:category)
      expected = {
        status: :success,
        data: { category: category.as_response}
      }.to_json
      # When
      get "/categories/#{category.id}"
      # then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /create' do
    it 'Should return exception when input duplicate name' do
      # Given
      category = FactoryBot.create(:category)
      expected = {
        status: :bad_request,
        message: "Kategori ini sudah ada"
      }.to_json
      # When
      post '/categories', params: { name: category.name }
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(400)
    end

    it 'Should success create new category' do
      # Given
      category = FactoryBot.build(:category)
      expected = {
        status: :created,
        message: "Berhasil menambahkan kategori",
        data: { categoryId: 1 }
      }.to_json
      # When
      post '/categories', params: { name: category.name }
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(201)
    end

    it 'Should return exception when not input parameter name' do
       # Given
      category = FactoryBot.create(:category)
      expected = {
        status: :bad_request,
        message: "Kolom nama kategori wajib di isi"
      }.to_json
      # When
      post '/categories'
      # Then
      expect(response.body).to eq(expected.to_s)
      expect(response).to have_http_status(400)
    end
  end
  
end
