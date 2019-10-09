class Personal < ApplicationRecord
  #Validation
  validates :first_name, length: {maximum: 35}
  validates :first_name, presence: true
  validates :last_name, length: {maximum: 35}
  validates :first_name, presence: true
  validates :first_name_kana, length: {maximum: 35}
  validates :first_name_kana, presence: true
  validates :last_name_kana, length: {maximum: 35}
  validates :first_name_kana, presence: true
  validates :zip_code,length: {maximum: 8}
  validates :city,length: {maximum: 50}
  validates :address,length: {maximum: 100}
  validates :building,length: {maximum: 100}
  validates :cellular_phone_number,length: {maximum: 35}
  belongs_to :user
  #belongs_to_active_hash :prefecture
end
