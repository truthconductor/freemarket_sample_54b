FactoryBot.define do
  factory :deliver_day do
    id                {1}
    day               {Faker::Name.name}
  end
end