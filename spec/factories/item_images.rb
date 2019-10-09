FactoryBot.define do

  factory :item_image do
    image            {Rack::Test::UploadedFile.new(File.join(Rails.root, '/public/images/delivery_jitensya.png'))}
    item_id          {1}
  end
end