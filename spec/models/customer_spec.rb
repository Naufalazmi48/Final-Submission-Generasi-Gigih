require 'rails_helper'
require 'simplecov'
SimpleCov.start
RSpec.describe Customer, type: :model do

  before(:each) do
    Customer.delete_all
  end
  
  it 'should return exception when using invalid email format' do
    customer = Customer.new(email: "abcd.com")
    customer.valid?
    expect(customer.errors[:email]).to include("is invalid")
  end

  it 'should return exception when using duplicate email' do
    customer1 = Customer.create(email: "naufalazmi@gmail.com")
    customer2 = Customer.new(email: "naufalazmi@gmail.com")

    customer2.valid?
    expect(customer2.errors[:email]).to include('has already been taken')
  end

  it 'should success when using correct email format' do
    expect(Customer.create(email: "naufalazmi@gmail.com")).to be_valid
  end
end