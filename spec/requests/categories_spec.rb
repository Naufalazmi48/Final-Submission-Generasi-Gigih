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
end
