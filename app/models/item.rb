class Item < ApplicationRecord
extend ActiveHash::Associations::ActiveRecordExtensions
  #Validation
  validates :name, :description, :amount, presence: true
  validates :name, length: { maximum: 40 }
  validates :amount, inclusion: { in: 300..9999999 }
  validate :check_image, :check_prefecture, :image_size
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

  private
  def check_image
    if item_images.empty?
      errors.add(:item_images, "がありません")
    end
  end

  def image_size
    item_images.each do |i|
      if i.image.size > 3.megabytes
        errors.add(:item_images, "サイズは3MB以下にしてください")
        break
      end
    end
  end
  
  def check_prefecture
    if prefecture_id.nil?
      errors.add(:prefecture_id, "選択してください")
    end
  end
end