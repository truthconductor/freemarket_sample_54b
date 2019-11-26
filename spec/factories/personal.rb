FactoryBot.define do
  factory :personal do
    id                      {1}
    last_name               {Faker::Name.last_name}
    first_name              {Faker::Name.first_name}
    last_name_kana          {'アアア'}
    first_name_kana         {'アアア'}
    zip_code                {Faker::Address.zip_code}
    prefecture_id           {Faker::Number.between(from: 1, to: 47)}
    city                    {Faker::Address.city}
    address                 {Faker::Address.street_name}
    building                {Faker::Address.secondary_address}
    cellular_phone_number            {''}
  end
end