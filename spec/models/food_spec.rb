require 'rails_helper'

RSpec.describe Food, type: :model do

  before(:each) do
    Food.delete_all
    Category.delete_all
  end
  
  describe 'creational' do
    it 'has a valid factory' do
      expect(FactoryBot.build(:food, name: 'makanan1', categories: [Category.new(name: 'category1')])).to be_valid
    end

    it 'is invalid without a name' do
      food = FactoryBot.build(:food, name: nil)
      food.valid?
      expect(food.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with a duplicate name' do
      food1 = FactoryBot.create(:food, name: 'Nasi Uduk', categories: [Category.new(name: 'category1')])
      food2 = FactoryBot.build(:food, name: 'Nasi Uduk')

      food2.valid?

      expect(food2.errors[:name]).to include('has already been taken')
    end

    it "food price can't less than 0.01" do
      food = FactoryBot.build(:food, price: 0.001)

      food.valid?

      expect(food.errors[:price]).to include('must be greater than or equal to 0.01')
    end

    it 'description must less than 150 character' do
      food = FactoryBot.build(:food, description: 'loremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsumloremipsum')

      food.valid?
      expect(food.errors[:description]).to include('is too long (maximum is 150 characters)')
    end

    it 'create food without categories' do
      food = FactoryBot.build(:food, categories: [])

      food.valid?
      expect(food.errors[:categories]).to include("can't be blank")
    end

    it 'create food by same categories' do
      category = Category.create(name: 'category1')
      food = FactoryBot.create(:food, categories: [category])
      food1 = FactoryBot.build(:food, name: 'tes', categories: [category])

      expect(food1).to be_valid
    end
  end

  describe 'search' do
    it 'search by category food' do
      food = FactoryBot.create(:food, name: 'makanan1', categories: [Category.new(name: 'makanan')])
      food2 = FactoryBot.create(:food, name: 'makanan2', categories: [Category.new(name: 'minuman')])
      food3 = FactoryBot.create(:food, name: 'makanan 3', categories: [Category.new(name: 'jajanan')])

      expect(Food.search_by_category('makanan')).to eq([food])
    end

    it 'search by contains of name' do
      food = FactoryBot.create(:food, name: 'Sushi',
      categories: [Category.new(name: 'makanan')])
      food1 = FactoryBot.create(:food, name: 'Sashimi',
      categories: [Category.new(name: 'makanan1')])
      food2 = FactoryBot.create(:food, name: 'Krabby',
      categories: [Category.new(name: 'makanan2')])

      expect(Food.find_by(name: 's')).to eq([food, food1])
    end
  end
end
