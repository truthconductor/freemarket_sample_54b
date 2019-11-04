# トップページ
crumb :root do
  link "メルカリ", root_path
end

# トップページ > マイページ
crumb :mypage do
  link "マイページ", mypage_path
  parent :root
end

# トップページ > マイページ > プロフィール
crumb :new_mypage_profiles do
  link "プロフィール", new_mypage_profiles_path
  parent :mypage
end

# トップページ > マイページ > プロフィール
crumb :edit_mypage_profiles do
  link "プロフィール", edit_mypage_profiles_path
  parent :mypage
end

# NOTE: 本来は（出品中・取引中・売却済）が上位リンクに存在するが現時点で未実装のためマイページの下位に置いている
# トップページ > マイページ > 出品商品画面
crumb :item do |item|
  link "出品商品画面", item_path(item)
  parent :mypage
end

# トップページ > マイページ > 支払い方法
crumb :mypage_cards do
  link "支払い方法", mypage_cards_path
  parent :mypage
end

# トップページ > マイページ > 支払い方法 > クレジットカード情報入力
crumb :new_mypage_card do
  link "クレジットカード情報入力", new_mypage_card_path
  parent :mypage_cards
end

# トップページ > ユーザー
crumb :user do |user|
  link user.profile&.nickname, user_path(user)
  parent :root
end