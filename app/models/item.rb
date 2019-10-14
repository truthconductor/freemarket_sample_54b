class Item < ApplicationRecord
extend ActiveHash::Associations::ActiveRecordExtensions
  #Validation
  validates :name, :description, :amount, presence: true
  validates :name, length: { maximum: 40 }
  validates :amount, inclusion: { in: 300..9999999 }
  validate :check_image, :check_prefecture
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
  # scope
  scope :recent, -> (count) { order(id: :desc).limit(count) }
  def check_image
    if item_images.empty?
      errors.add(:item_images, "画像がありません")
    end
  end
  
  def check_prefecture
    if prefecture_id.nil?
      errors.add(:prefecture, "選択してください")
    end
  end
end