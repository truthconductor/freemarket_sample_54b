class Brand < ApplicationRecord
  #Validation
  validates :name, :first_letter, presence: true
  #Association
  has_many :categories, through: :categories_brands
  has_many :categories_brands
  has_many :items
end
