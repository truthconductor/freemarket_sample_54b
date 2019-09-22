class Brand < ApplicationRecord
  has_many :categories, through: :categories_brands
  has_many :items
end
