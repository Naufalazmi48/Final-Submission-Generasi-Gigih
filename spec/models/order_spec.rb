require 'rails_helper'

RSpec.describe Order, type: :model do
   before(:all) do
    Customer.delete_all
    Order.delete_all
  end
  
  it 'should return exception when user id not found' do
    order = Order.new(customer_id: '1', date: '21/04/2022')

    order.valid?

    expect(order.errors[:customer]).to include('must exist')
  end

  it 'should success when create order with valid user id' do
    customer = Customer.create(email: "naufalazmi@gmail.com")

    expect(Order.new(customer_id: customer.id, date: '21/04/2022')).to be_valid
  end

end