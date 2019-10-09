class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable 

  has_one :profile, dependent: :destroy
  has_one :personal, dependent: :destroy
  accepts_nested_attributes_for :personal
  has_one :deliver_address, dependent: :destroy
  has_many :items, class_name: 'Item', foreign_key: 'seller_id'
  has_many :buyer_deals, class_name: 'Deal', foreign_key: 'buyer_id'
  has_many :seller_deals, class_name: 'Deal', foreign_key: 'seller_id'
  has_many :item_comments
  has_many :item_likes
  has_one :credit_card

  
end
