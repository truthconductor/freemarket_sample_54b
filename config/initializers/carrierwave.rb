require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    #以下の2行をcredential.yml仕様に書き換え
    aws_access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
    aws_secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'upload-image3'
  config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/upload-image3'
end