FactoryBot.define do
  factory :category do
    id                {1}
    name              {Faker::Name.name}
  end
end