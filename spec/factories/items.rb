FactoryBot.define do

  factory :item do
    name                 {Faker::Name.name}
    description          {Faker::Name.name}
    amount               {rand(300..9999999)}
    prefecture_id        {1}
    brand_id             {nil}
    deal_id              {nil}
    seller_id            {1}

    item_state
    deliver_expend
    deliver_method
    deliver_day
    sales_state
    category
  end
end