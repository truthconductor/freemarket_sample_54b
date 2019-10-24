FactoryBot.define do
  factory :deal do
    id                {1}
    date              {Faker::Date.forward(days: 30)}
    buyer             {}
    seller            {}
    item              {}
    payment           {}
  end
end