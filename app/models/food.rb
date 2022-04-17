class Food < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :price, numericality: true
    validates_numericality_of :price, greater_than_or_equal_to: 0.01
    validates_length_of :description, :maximum => 150
    validates :categories, presence: true
  
    has_many :categories
  
    def self.search_by_category(category)
      self.joins(:categories).where('categories.name LIKE ?', "%#{category}%").distinct.to_a
    end
  
    def self.find_by(query)
      if query.key?(:name)
        where('name LIKE ?', "#{query[:name]}%").to_a
      end
    end
    
  end