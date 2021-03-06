class Category < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    belongs_to :food, optional: true

    def as_response
      self.attributes.slice("id", "name")
    end
  end
  