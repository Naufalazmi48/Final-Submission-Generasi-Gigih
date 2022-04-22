class Order < ApplicationRecord
  attribute :status, :string, default: 'new'

  belongs_to :customer
  has_many :orderdetails

  def self.list_order
    orders = Order.all

    list_order = []

    orders.each do |order|
      list_order << order.detail
    end
    list_order
  end

  def detail
    hash_order = {}
    hash_order[:id] = self.id
    hash_order[:email] = self.customer.email
    hash_order[:date] = self.date
    hash_order[:status] = self.status
    hash_order[:foods] = []
    total = 0

     order_details = Orderdetail.where(order_id: self.id).to_a
      order_details.each do |detail|
        hash_detail = {}
        hash_detail[:name] = detail.food.name
        hash_detail[:price] = detail.price
        hash_detail[:qty] = detail.qty
        total += detail.price * detail.qty

        hash_order[:foods] << hash_detail
      end
    hash_order[:total] = total
    hash_order
  end
  
end
