class Deal < ApplicationRecord
  #Validation
  validates :item, :payment, presence: true
  #Association
  has_one :item
  has_one :payment
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
end
