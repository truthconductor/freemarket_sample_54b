class Category < ApplicationRecord
  #Validation
  validates :name, presence: true
  #Association
  has_many :categories_brands
  has_many :brands, through: :categories_brands
  has_many :items
  has_ancestry
end
