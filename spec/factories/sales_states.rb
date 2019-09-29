FactoryBot.define do
  factory :sales_state do
    id                   {1}
    state                {Faker::Name.name}
  end
end