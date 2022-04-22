require 'rails_helper'

RSpec.describe Orderdetail, type: :model do
  after(:all) do
    Food.delete_all
    Category.delete_all
    Order.delete_all
    Customer.delete_all
    Orderdetail.delete_all
  end

  before(:all) do
    @food = FactoryBot.create(:food)
    customer = Customer.create(email: 'naufalazmi@gmail.com')
    @order = Order.create(customer_id: customer.id, date: '21/04/2022')
  end

  it 'should return exception order detail when invalid order id' do
    order_detail = Orderdetail.new(order_id: '5', food_id: @food.id, qty: 2, price: 10_000)
    order_detail.valid?
    expect(order_detail.errors[:order]).to include('must exist')
  end

  it 'should return exception order detail when invalid food id' do
    order_detail = Orderdetail.new(order_id: @order.id, food_id: '11', qty: 2, price: 10_000)
    order_detail.valid?
    expect(order_detail.errors[:food]).to include('must exist')
  end

  it 'should return exception when qty and price is not numeric' do
    order_detail = Orderdetail.new(order_id: @order.id, food_id: @food.id, qty: "b", price: "a")
    order_detail.valid?
    expect(order_detail.errors[:qty]).to include('is not a number')
    expect(order_detail.errors[:price]).to include('is not a number')
  end

  it 'should success add order detail' do
    expect(Orderdetail.new(order_id: @order.id, food_id: @food.id, qty: 2, price: 10_000)).to be_valid
  end
  
end
