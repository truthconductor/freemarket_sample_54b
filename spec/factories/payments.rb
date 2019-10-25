FactoryBot.define do
  factory :payment do
    id                {1}
    amount            {rand(300..9999999)}
    point             {rand(0..100000)}
    deal_id           {}
  end
end