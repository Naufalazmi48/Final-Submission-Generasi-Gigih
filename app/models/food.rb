class Food < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, numericality: true
  validates_numericality_of :price, greater_than_or_equal_to: 0.01
  validates_length_of :description, maximum: 150
  validates :categories, presence: true

  has_many :categories
  has_many :orderdetails

  def self.search_by_category(category)
    joins(:categories).where('categories.name LIKE ?', "%#{category}%").distinct.to_a
  end

  def self.find_by(query)
    where('name LIKE ?', "#{query[:name]}%").to_a if query.key?(:name)
  end

  def as_response
    hash_response = as_json(include: { categories: { only: :name } })
    hash_response.delete("created_at")
    hash_response.delete("updated_at")
    hash_response
  end
end
