# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

# 配送料の負担
if DeliverExpend.count == 0
  DeliverExpend.create(expend: "送料込み（出品者負担）")
  DeliverExpend.create(expend: "着払い（購入者負担）")
end

# 配送の方法
if DeliverMethod.count == 0
  DeliverMethod.create(method: "未定", cash_on_delivery: true)
  DeliverMethod.create(method: "らくらくメルカリ便", cash_on_delivery: false)
  DeliverMethod.create(method: "ゆうメール", cash_on_delivery: true)
  DeliverMethod.create(method: "レターパック", cash_on_delivery: false)
  DeliverMethod.create(method: "普通郵便（定形、定形外）", cash_on_delivery: false)
  DeliverMethod.create(method: "クロネコヤマト", cash_on_delivery: true)
  DeliverMethod.create(method: "ゆうパック", cash_on_delivery: true)
  DeliverMethod.create(method: "クリックポスト", cash_on_delivery: false)
  DeliverMethod.create(method: "ゆうパケット", cash_on_delivery: false)
end

# 配送の日数
if DeliverDay.count == 0
  DeliverDay.create(day: "1〜2日で発送")
  DeliverDay.create(day: "2〜3日で発送")
  DeliverDay.create(day: "4〜7日で発送")
end

# 商品の状態
if ItemState.count == 0
  ItemState.create(state: "新品、未使用")
  ItemState.create(state: "未使用に近い")
  ItemState.create(state: "目立った傷や汚れなし")
  ItemState.create(state: "やや傷や汚れあり")
  ItemState.create(state: "傷や汚れあり")
  ItemState.create(state: "全体的に状態が悪い")
end

# 商品の状態
if SalesState.count == 0
  SalesState.create(state: "販売中")
  SalesState.create(state: "一時停止")
  SalesState.create(state: "売り切れ")
  SalesState.create(state: "販売停止")
end

# カテゴリ
if Category.count == 0
  category1 = Category.new
  category2 = Category.new
  category3 = Category.new
  # CSVからカテゴリーを反映
  CSV.foreach("db/category.csv") do |row|
    if row[0]
      category1 = Category.create(name: row[0])
    elsif row[1]
      category2 = category1.children.create(name: row[1])
    elsif row[2]
      category3 = category2.children.create(name: row[2])
    end
  end
end

# ブランド
if Brand.count == 0

  category_ladies = Category.find_by(name: "レディース")
  CSV.foreach("db/brand-ladies.csv") do |row|
    brand = Brand.create(first_letter: row[0], name: row[1])
    CategoriesBrand.create(category_id: category_ladies.id, brand_id: brand.id)
  end

  category_mens = Category.find_by(name: "メンズ")
  CSV.foreach("db/brand-mens.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_mens.id, brand_id: brand.id)
  end

  category_kids = Category.find_by(name: "ベビー・キッズ")
  CSV.foreach("db/brand-baby.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_kids.id, brand_id: brand.id)
  end

  category_interior = Category.find_by(name: "インテリア・住まい・小物")
  CSV.foreach("db/brand-interior.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_interior.id, brand_id: brand.id)
  end

  category_kitchen = Category.find_by(name: "キッチン/食器")
  CSV.foreach("db/brand-kitchen.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_kitchen.id, brand_id: brand.id)
  end

  category_watches = Category.where(name: "時計")
  CSV.foreach("db/brand-watch.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    # 男女それぞれの時計カテゴリーとブランドを紐付ける
    category_watches.each do |category_watch|
      CategoriesBrand.create(category_id: category_watch.id, brand_id: brand.id)
    end
  end

  category_cosme = Category.find_by(name: "コスメ・香水・美容")
  CSV.foreach("db/brand-cosme.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_cosme.id, brand_id: brand.id)
  end

  category_videogame= Category.find_by(name: "テレビゲーム")
  CSV.foreach("db/brand-videogame.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_videogame.id, brand_id: brand.id)
  end

  category_sports = Category.find_by(name: "スポーツ・レジャー")
  CSV.foreach("db/brand-sports.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_sports.id, brand_id: brand.id)
  end

  category_smartphone = Category.find_by(name: "スマートフォン/携帯電話")
  CSV.foreach("db/brand-smartphone.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_smartphone.id, brand_id: brand.id)
  end

  category_bike = Category.find_by(name: "オートバイ車体")
  category_bike_parts = Category.find_by(name: "オートバイパーツ")
  category_bike_accessory = Category.find_by(name: "オートバイアクセサリー")
  CSV.foreach("db/brand-bike.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_bike.id, brand_id: brand.id)
    CategoriesBrand.create(category_id: category_bike_parts.id, brand_id: brand.id)
    CategoriesBrand.create(category_id: category_bike_accessory.id, brand_id: brand.id)
  end

  category_instruments= Category.find_by(name: "楽器/器材")
  CSV.foreach("db/brand-instruments.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_instruments.id, brand_id: brand.id)
  end

  category_car_wheel = Category.find_by(name: "自動車タイヤ/ホイール")
  category_car_parts = Category.find_by(name: "自動車パーツ")
  CSV.foreach("db/brand-instruments.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_car_wheel.id, brand_id: brand.id)
    CategoriesBrand.create(category_id: category_car_parts.id, brand_id: brand.id)
  end

  category_food = Category.find_by(name: "食品")
  category_drink = Category.find_by(name: "飲料/酒")
  CSV.foreach("db/brand-food.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_food.id, brand_id: brand.id)
    CategoriesBrand.create(category_id: category_drink.id, brand_id: brand.id)
  end

  category_japanesecar = Category.find_by(name: "国内自動車本体")
  CSV.foreach("db/brand-japanesecar.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_japanesecar.id, brand_id: brand.id)
  end

  category_foreigncar = Category.find_by(name: "外国自動車本体")
  CSV.foreach("db/brand-foreigncar.csv") do |row|
    brand = Brand.find_by(name: row[1])
    unless brand
      brand = Brand.create(first_letter: row[0], name: row[1])
    end
    CategoriesBrand.create(category_id: category_foreigncar.id, brand_id: brand.id)
  end
end