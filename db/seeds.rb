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
      category2.children.create(name: row[2])
    end
  end
end