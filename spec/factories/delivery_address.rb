FactoryBot.define do
  factory :delivery_address do
    id                      {1}
    last_name               {Faker::Name.last_name}
    first_name              {Faker::Name.first_name}
    last_name_kana          {'カナエ'}
    first_name_kana         {'カナコ'}
    zip_code                {Faker::Address.zip_code}
    prefecture_id           {Faker::Number.between(from: 1, to: 47)}
    city                    {Faker::Address.city}
    address                 {Faker::Address.street_name}
    building                {Faker::Address.secondary_address}
    # Faker::PhoneNumber.phone_numberではphonelibの日本電話番号形式に準拠しない電話番号を生成するためテスト用番号はテストコードで作成する
    phone_number            {''}
  end
end