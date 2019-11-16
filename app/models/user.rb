class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable,:omniauthable,
         omniauth_providers:[:facebook,:google_oauth2]


  has_one :profile, dependent: :destroy
  has_one :personal, dependent: :destroy
  accepts_nested_attributes_for :personal
  accepts_nested_attributes_for :profile
  validates :personal, associated: true
  has_one :deliver_address, dependent: :destroy
  has_one :delivery_address, dependent: :destroy
  has_many :items, class_name: 'Item', foreign_key: 'seller_id'
  has_many :buyer_deals, class_name: 'Deal', foreign_key: 'buyer_id'
  has_many :seller_deals, class_name: 'Deal', foreign_key: 'seller_id'
  has_many :item_comments
  has_many :item_likes
  has_one :credit_card, dependent: :destroy

  # 購入可能な情報を保持しているか判定する
  def can_purchase?
    return delivery_address != nil && credit_card&.getPayjpDefaultCard != nil
  end

  # sns認証後、ユーザーの有無に応じて挙動を変更する
  def self.from_omniauth(auth)
    # uidとproviderでユーザーを検索
    user = User.find_by(uid: auth.uid, provider: auth.provider)
    if user
      #SNSを使って登録したユーザーがいたらそのユーザーを返す
      return user
    else
      #いなかった場合はnewします。
      new_user = User.new(
        email: auth.info.email,
        uid: auth.uid,
        provider: auth.provider,
        #パスワードにnull制約があるためFakerで適当に作ったものを突っ込んでいます
        password: Faker::Internet.password(min_length: 7,max_length: 128)
      )
      return new_user
    end
  end

end
