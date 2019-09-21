# README

## usersテーブル（ユーザー）

|属性|Column|Type|Options|
|---|---|---|---|
|メールアドレス|email|string|null: false, unique: true|
|パスワード|encrypted_password|string|null: false|

### index

- add_index :users, :nickname

### Association

- has_one :profile, dependent: :destroy
- has_one :personal, dependent: :destroy
- has_one :deliver_address, dependent: :destroy
- has_many :providers, dependent: :destroy
- has_many :items
- has_many :buyer_transactions, class_name: 'Transaction', foreign_key: 'buyer_id'
- has_many :seller_transactions, class_name: 'Transaction', foreign_key: 'seller_id'
- has_many :item_comments
- has_many :item_likes
- has_one :credit_card

## profilesテーブル（プロフィール）

|属性|Column|Type|Options|
|---|---|---|---|
|ニックネーム|nickname|string|null: false, limit:20|
|紹介文|introduction|text|limit:1000|
|プロフィール画像|avatar|string||
|ユーザー|user_id|reference|null: false, foreign_key: true|

### Association

- belongs_to :user

## personalsテーブル（本人情報）

|属性|Column|Type|Options|
|---|---|---|---|
|姓|last_name|string|null: false, limit:35|
|名|first_name|string|null: false, limit:35|
|セイ|last_name_kana|string|null: false, limit:35|
|メイ|first_name_kana|string|null: false, limit:35|
|郵便番号|zip-code|string|limit:8|
|都道府県|prefecture_id|reference||
|市区町村|city|string|limit:50|
|番地|address|string|limit:100|
|建物名|building|string|limit:100|
|携帯番号|cellular_phone_number|string|limit:35|
|ユーザー|user_id|reference|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to_active_hash :prefecture

## deliver_addressesテーブル（発送元・お届け先）

|属性|Column|Type|Options|
|---|---|---|---|
|姓|last_name|string|null: false, limit:35|
|名|first_name|string|null: false, limit:35|
|セイ|last_name_kana|string|null: false, limit:35|
|メイ|first_name_kana|string|null: false, limit:35|
|郵便番号|zip_code|string|null: false, limit:8|
|都道府県|prefecture_id|reference|null: false|
|市区町村|city|string|null: false, limit:50|
|番地|address|string|null: false, limit:100|
|建物名|building|string|limit:100|
|電話|phone_number|string|limit:35|
|ユーザー|user_id|reference|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to_active_hash :prefecture

## providersテーブル（SNS認証プロバイダ）

|属性|Column|Type|Options|
|---|---|---|---|
|認証プロバイダ|provider|string|null: false|
|UID|uid|string|null: false|
|ユーザー|user_id|reference|null: false, foreign_key: true|

- belongs_to :user

## categoriesテーブル（カテゴリー）

|属性|Column|Type|Options|
|---|---|---|---|
|カテゴリ名|name|string|null: false|
|経路|ancestry|string||

### index

- add_index :categories, :ancestry

### Association

- has_many :brands, through: :categories_brands
- has_many :items

## brandsテーブル（ブランド）

|属性|Column|Type|Options|
|---|---|---|---|
|ブランド名|name|string|null: false|

### Association

- has_many :categories, through: :categories_brands
- has_many :items

## categories_brandsテーブル（中間テーブル）

|属性|Column|Type|Options|
|---|---|---|---|
|カテゴリーid|category_id|reference|null: false, foreign_key: true|
|ブランドid|brand_id|reference|null: false, foreign_key: true|

### Association

- belongs_to :category
- belongs_to :brand

## itemsテーブル（商品）

|属性|Column|Type|Options|
|---|---|---|---|
|商品名|name|string|null: false, limit:40|
|説明|description|text|null: false|
|価格|amount|integer|null: false|
|状態id|item_state_id|reference|null: false, foreign_key: true|
|配送料負担id|deliver_expend_id|reference|null: false, foreign_key: true|
|配送方法id|prefecture_id|reference|null: false, foreign_key: true|
|都道府県id|deliver_day_id|reference|null: false, foreign_key: true|
|発送日数id|sales_state_id|reference|null: false, foreign_key: true|
|カテゴリid|category_id|reference|null: false, foreign_key: true|
|ブランドid|brand_id|reference|foreign_key: true|

### index

- add_index :items, :name
- add_index :items, :amount

### Association

- has_many :item_images
- has_many :item_messages
- has_many :item_likes
- belongs_to :item_state
- belongs_to :deliver_expend
- belongs_to_active_hash :prefecture
- belongs_to :deliver_day
- belongs_to :sales_state
- belongs_to :category
- belongs_to :brand
- belongs_to :transaction

## item_imagesテーブル（出品画像）

|属性|Column|Type|Options|
|---|---|---|---|
|画像|image|string|null: false|
|商品id|item_id|reference|null: false, foreign_key: true|

### Association

- belongs_to :item

## item_statesテーブル（商品状態）

|属性|Column|Type|Options|
|---|---|---|---|
|状態|state|string|null: false|

### Association

- has_many :items

## deliver_expendsテーブル（配送料負担先）

|属性|Column|Type|Options|
|---|---|---|---|
|負担先|expend|string|null: false|

### Association

- has_many :items

## deliver_methodsテーブル（配送方法）

|属性|Column|Type|Options|
|---|---|---|---|
|配送方法|method|string|null: false|
|着払い可|cod|boolean|null: false|

### Association

- has_many :items

## prefectures [ActiveHash]（都道府県）

|属性|Column|Type|Options|
|---|---|---|---|
|都道府県|prefecture|string|null: false|

### Association

- has_many :items
- has_many :personals
- has_many :deliver_addresses

## deliver_daysテーブル（発送日数）

|属性|Column|Type|Options|
|---|---|---|---|
|発送日数|day|string|null: false|

### Association

- has_many :items

## sales_statesテーブル（販売状態）

|属性|Column|Type|Options|
|---|---|---|---|
|販売状態|state|string|null: false|

### Association

- has_many :items

## item_comments（商品コメント）

|属性|Column|Type|Options|
|---|---|---|---|
|メッセージ|message|text|null: false|
|削除|delete|boolean|null: false|
|ユーザーid|user_id|reference|null: false, foreign_key: true|
|商品id|item_id|reference|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :item

## item_likesテーブル（商品いいね）

|属性|Column|Type|Options|
|---|---|---|---|
|ユーザーid|user_id|reference|null: false, foreign_key: true|
|商品id|item_id|reference|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :item

## transactionsテーブル（取引）

|属性|Column|Type|Options|
|---|---|---|---|
|取引日|date|datetime|null: false|
|購入者|buyer_id|reference|null: false|
|販売者|seller_id|reference|null: false|

### Association

- has_one :item
- has_one :payment
- belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'
- belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'

## paymentsテーブル（支払い）

|属性|Column|Type|Options|
|---|---|---|---|
|金額|amount|integer|null: false|
|ポイント|point|integer|null: false|
|取引id|buyer_id|reference|null: false, foreign_key: true|

### Association

- belongs_to :transaction

## credit_cardsテーブル（クレジットカード）

|属性|Column|Type|Options|
|---|---|---|---|
|顧客id(pay.jp)|customer_id|string|null: false|
|ユーザーid|user_id|reference|null: false, foreign_key: true|

### Association

- belongs_to :user
