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

  
end
