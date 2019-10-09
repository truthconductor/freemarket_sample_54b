FactoryBot.define do
  factory :deliver_method do
    id                      {1}
    #予約語とカラム名が被る場合のエラー回避、以下は method {Faker::Name.name}と同じ
    add_attribute(:method)  {Faker::Name.name}
    cash_on_delivery        {true}
  end
end