class DeliveryAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  #Validation
  validates :last_name, presence: true
  validates :last_name, length: {maximum: 35}
  validates :first_name, presence: true
  validates :first_name, length: {maximum: 35}
  validates :last_name_kana, presence: true
  validates :last_name_kana, length: {maximum: 35}
  validates :last_name_kana, format: {message: "を全角カナで入力してください", with: /\A[\p{katakana}\p{hiragana}\p{blank}ー－]+\z/ }
  validates :first_name_kana, presence: true
  validates :first_name_kana, length: {maximum: 35}
  validates :first_name_kana, format: {message: "を全角カナで入力してください", with: /\A[\p{katakana}\p{hiragana}\p{blank}ー－]+\z/ }
  validates :zip_code, presence: true
  validates :zip_code, length: {maximum: 8}
  validates :zip_code, format: {message: "を正しく入力してください", with: /\A[0-9]{3}-[0-9]{4}\z/}
  validate :check_prefecture
  validates :city, presence: true
  validates :city, length: {maximum: 50}
  validates :address, presence: true
  validates :address, length: {maximum: 100}
  validates :building, length: {maximum: 100}
  validates :phone_number, length: {maximum: 35}
  validate :check_phone_number
  #Association
  belongs_to :user
  belongs_to_active_hash :prefecture

  def check_prefecture
    if prefecture_id.nil?
      errors.add(:prefecture_id, "を選択してください")
    end
  end

  # 空欄を許容した上で日本国内の電話番号形式かバリデーションを行う
  def check_phone_number
    unless phone_number.blank? || Phonelib.valid_for_country?(phone_number, :jp)
      errors.add(:phone_number, "を正しく入力してください")
    end
  end
end
