require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  before(:each) do
    Category.delete_all
  end

  describe 'GET /index' do
    it 'should return all category'
  end
end
