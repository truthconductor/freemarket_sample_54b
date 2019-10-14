FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 8)
    sequence(:email) {Faker::Internet.email}
    password              {password}
    password_confirmation {password}
  end
end