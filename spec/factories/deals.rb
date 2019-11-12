FactoryBot.define do
  factory :deal do
    id                {1}
    date              {Faker::Date.forward(days: 30)}
    buyer             {}
    seller            {}
    deal_state_id     {2}
    item              {}
    payment           {}
  end
end