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
  validates :city,length: {maximum: 50}
  validates :address,length: {maximum: 100}
  validates :building,length: {maximum: 100}
  #phonelibで電話番号の正規化を実装
  validates :cellular_phone_number,phone: {allow_blank: true, countries: [:jp]}
  validates :birthdate, presence: true 
  belongs_to :user
  
  belongs_to_active_hash :prefecture
  #カタカナとひらがな以外のデータを制限
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{hiragana}\p{blank}ー－]+\z/  ,message: "ひらがなかカタカナで入力してください"}
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{hiragana}\p{blank}ー－]+\z/ ,message: "ひらがなかカタカナで入力してください"}

 
  

end
