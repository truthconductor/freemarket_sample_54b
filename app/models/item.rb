class Item < ApplicationRecord
extend ActiveHash::Associations::ActiveRecordExtensions
  #Validation
  validates :name, presence: true
  validates :name, length: { maximum: 40 }
  validates :description, presence: true
  validates :amount, presence: true
  validates :amount, inclusion: { in: 300..9999999 }
  #Association
  belongs_to :item_state
  belongs_to :deliver_expend
  belongs_to :deliver_method
  belongs_to_active_hash :prefecture
  belongs_to :deliver_day
  belongs_to :sales_state
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :deal, optional: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, allow_destroy: true
end
