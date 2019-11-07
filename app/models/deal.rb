class Deal < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  #Validation
  validates :item, :payment, presence: true
  #Association
  has_one :item
  has_one :payment, dependent: :destroy
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to_active_hash :deal_state
  # scope
  # 直近の取引を取得
  scope :recent, -> (count) { order(id: :desc).limit(count) }
  # 取引中（状態が取引完了でない）の取引を取得
  scope :in_progress, -> { where.not(deal_state_id: 5) }
  # 取引済み（状態が取引完了）の取引を取得
  scope :finished, -> { where(deal_state_id: 5) }
end
