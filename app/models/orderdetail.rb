class Orderdetail < ApplicationRecord
  validates :price, numericality: true
  validates :qty, numericality: true
  
  belongs_to :food
  belongs_to :order

  def as_response
    as_json(include: { food: { only: :name } })
  end
end
