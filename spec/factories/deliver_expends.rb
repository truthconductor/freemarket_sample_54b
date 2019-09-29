FactoryBot.define do
  factory :deliver_expend do
    id                   {1}
    expend               {Faker::Name.name}
  end
end