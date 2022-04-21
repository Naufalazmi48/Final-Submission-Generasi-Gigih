require 'rails_helper'

RSpec.describe Category, type: :model do
  after(:all) do
    Category.delete_all
  end
  
  it 'has a valid factory' do
      expect(FactoryBot.build(:category)).to be_valid
    end

    it 'is invalid without a name' do
      category = FactoryBot.build(:category, name: nil)
      category.valid?
      expect(category.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with a duplicate name' do
      category1 = FactoryBot.create(:category, name: 'Food')
      category2 = FactoryBot.build(:category, name: 'Food')

      category2.valid?

      expect(category2.errors[:name]).to include('has already been taken')
    end
end
