FactoryBot.define do
  factory :item_state do
    id                   {1}
    state                {Faker::Name.name}
  end
end