class Personal < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  #Validation
  validates :first_name, length: {maximum: 35}
  validates :first_name, presence: true
  validates :last_name, length: {maximum: 35}
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :first_name_kana, length: {maximum: 35}
  validates :first_name_kana, presence: true
  validates :last_name_kana, length: {maximum: 35}
  validates :first_name_kana, presence: true
  validates :zip_code,length: {maximum: 8}
  validates :zip_code,allow_blank: true, format: {message: "を正しく入力してください", with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates :prefecture_id,presence: true,allow_blank: true
  validates :city,length: {maximum: 50}
  validates :address,length: {maximum: 100}
  validates :building,length: {maximum: 100}
  #phonelibで電話番号の正規化を実装
  validates :cellular_phone_number,length: {maximum: 35}
  validates :cellular_phone_number, presence: true
  validate :check_phone_number
  validates :birthdate, presence: true,format: {message: "を正しく入力してください", with: /\A[1-9]{1}[0-9]{3}-[0-9]{2}-[0-9]{2}\z/}
  #validate :date_valid
  #カタカナとひらがな以外のデータを制限
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{hiragana}\p{blank}ー－]+\z/  ,message: "はひらがなかカタカナで入力してください"}
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{hiragana}\p{blank}ー－]+\z/ ,message: "はひらがなかカタカナで入力してください"}
  #Association
  belongs_to :user
  belongs_to_active_hash :prefecture


  def check_phone_number
    unless cellular_phone_number.blank? || Phonelib.valid_for_country?(cellular_phone_number, :jp)
      errors.add(:cellular_phone_number, "を正しく入力してください")
    end
  end

end
