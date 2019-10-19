class DeliveryAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  #Validation
  validates :last_name, presence: true
  validates :last_name, length: {maximum: 35}
  validates :first_name, presence: true
  validates :first_name, length: {maximum: 35}
  validates :last_name_kana, presence: true
  validates :last_name_kana, length: {maximum: 35}
  validates :first_name_kana, presence: true
  validates :first_name_kana, length: {maximum: 35}
  validates :zip_code, presence: true
  validates :zip_code, length: {maximum: 8}
  validate :check_prefecture
  validates :city, presence: true
  validates :city, length: {maximum: 50}
  validates :address, presence: true
  validates :address, length: {maximum: 100}
  validates :building, length: {maximum: 100}
  validates :phone_number,length: {maximum: 35}
  #Association
  belongs_to :user
  belongs_to_active_hash :prefecture

  def check_prefecture
    if prefecture_id.nil?
      errors.add(:prefecture, "選択してください")
    end
  end
end
